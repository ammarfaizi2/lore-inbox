Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130216AbQLONbl>; Fri, 15 Dec 2000 08:31:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130386AbQLONbb>; Fri, 15 Dec 2000 08:31:31 -0500
Received: from tomts5.bellnexxia.net ([209.226.175.25]:21647 "EHLO
	tomts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S130216AbQLONbU>; Fri, 15 Dec 2000 08:31:20 -0500
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: linux-kernel@vger.kernel.org
Subject: [lkml]Re: VM problems still in 2.2.18
Date: Fri, 15 Dec 2000 08:00:44 -0500
X-Mailer: KMail [version 1.1.99]
Content-Type: text/plain; charset=US-ASCII
Cc: alan@lxorguk.ukuu.org.uk
MIME-Version: 1.0
Message-Id: <00121508004400.16895@oscar>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

> > slrnpull --expire on a news-spool of about 600 Mb in 200,000 files gave
> > a lot of 'trying_to_free..' errors.
> > 
> > 2.2.18 + VM-global, booted with mem=32M:
> > 
> > slrnpull --expire on the same spool worked fine.
> 
> I think Andrea just earned his official God status ;)

I have been using the aa series kernels through out the 18pre series (with 
reiserfs).  They have worked very well.   Suggest you and Andrea talk and 
figure out what else from this series can be put into 19pre.  Believe the 
major changes left in the aa series are bigmem and lvm.  I would love to see 
lvm officially in 2.2...

Luck,

Ed Tomlinson
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
