Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289298AbSA2NbE>; Tue, 29 Jan 2002 08:31:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289296AbSA2Nay>; Tue, 29 Jan 2002 08:30:54 -0500
Received: from mx5.sac.fedex.com ([199.81.194.37]:15879 "EHLO
	mx5.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S289294AbSA2Nau>; Tue, 29 Jan 2002 08:30:50 -0500
Date: Tue, 29 Jan 2002 21:01:30 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Stephan von Krawczynski <skraw@ithnet.com>
cc: Jeff Chua <jchua@fedex.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Thomas Hood <jdthood@mail.com>,
        Linux Kernel <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: 2.4.18-pre7 slow ... apm problem
In-Reply-To: <200201282309.AAA22703@webserver.ithnet.com>
Message-ID: <Pine.LNX.4.44.0201292057370.600-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/29/2002
 09:05:39 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 01/29/2002
 09:05:41 PM,
	Serialize complete at 01/29/2002 09:05:41 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jan 2002, Stephan von Krawczynski wrote:

> Ok, I cannot see this one, I have no APM enabled on my boxes. Sorry.

If I set apm idle off, vmware guest os "ping localhost" works fine.

> As I never saw this with vmware 2 (even not on 2.4.18-pre7) I would
> say version 3 has a real problem somewhere.

Never had any problem with vmware3 until pre7.

Try to test vmware2 on pre7 with apm cpu_idle enabled. I think you'll see
the same problem. Again, pre6 with apm cpu_idle enabled works fine.

Jeff

