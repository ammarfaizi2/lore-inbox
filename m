Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315709AbSECVAB>; Fri, 3 May 2002 17:00:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315711AbSECVAB>; Fri, 3 May 2002 17:00:01 -0400
Received: from ppp-46-13.24-151.libero.it ([151.24.13.46]:1920 "EHLO cogno")
	by vger.kernel.org with ESMTP id <S315709AbSECVAA>;
	Fri, 3 May 2002 17:00:00 -0400
Date: Fri, 3 May 2002 22:59:50 +0200
From: andrea gelmini <andrea.gelmini@linux.it>
To: linux-kernel@vger.kernel.org
Subject: Re: Busy buffers in invalidate
Message-ID: <20020503205949.GA418@linux.it>
In-Reply-To: <3CAD91D7.53D03FBC@delusion.de> <E16tSqM-0008A9-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux 2.4.19-pre7-ac4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On ven, apr 05, 2002 at 01:29:26 +0100, Alan Cox wrote:
> > With 2.4.18 we recently get a lot of the following in the kernel log:
> > invalidate: busy buffer
> > 
> > Something to worry about?
> 
> Yes in some situations. Its fixed in 2.4.19pre5-ac2 and a bit before
well, i'm using 2.4.19-pre7-ac4 and if i run parted i've got a lot of
this messages.
it happens on a laptop asus k8400.

ciao,
andrea
