Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267432AbSKQBls>; Sat, 16 Nov 2002 20:41:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbSKQBlr>; Sat, 16 Nov 2002 20:41:47 -0500
Received: from mx11.dmz.fedex.com ([199.81.193.118]:19471 "EHLO
	mx11.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S267432AbSKQBlr>; Sat, 16 Nov 2002 20:41:47 -0500
Date: Sun, 17 Nov 2002 09:47:02 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Andries Brouwer <aebr@win.tue.nl>
cc: Jeff Chua <jchua@fedex.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Subject: Re: VFAT mount (bug or feature?
In-Reply-To: <20021116201944.GA1456@win.tue.nl>
Message-ID: <Pine.LNX.4.44.0211170944020.432-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/17/2002
 09:48:37 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 11/17/2002
 09:48:40 AM,
	Serialize complete at 11/17/2002 09:48:40 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 16 Nov 2002, Andries Brouwer wrote:

> > drwxr--r--   40 root     root         4096 Jan  1  1970 /dos
> >
> > Any patch for 2.4.20-rcx?
>
> Hm. Why do you think this is wrong? Didnt you ask for it?

No, I didn't ask for it.

But, 2.4.20-rc2 seems ok.

'mount -o umask=022' now works under 2.4.20-rc2.

Thanks,
Jeff.

