Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283060AbRLDLwu>; Tue, 4 Dec 2001 06:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283059AbRLDLwa>; Tue, 4 Dec 2001 06:52:30 -0500
Received: from dialup173.d1--Dbg1.Vie.AT.KPNQwest.net ([193.154.5.173]:4903
	"EHLO [193.154.5.173]") by vger.kernel.org with ESMTP
	id <S282370AbRLDLwR>; Tue, 4 Dec 2001 06:52:17 -0500
Date: Tue, 4 Dec 2001 12:50:59 +0100 (CET)
From: Markus Biermaier <mbier@eunet.at>
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
cc: linux-kernel@vger.kernel.org, mayfield+usb@sackheads.org
Subject: Re: Problem with 'mount -t vfat' on PPC
In-Reply-To: <87zo4zla84.fsf@devron.myhome.or.jp>
Message-ID: <Pine.LNX.4.21.0112041247290.1343-100000@linuxpb.mboffice>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 4 Dec 2001, OGAWA Hirofumi wrote:

> Hi,
> 
> Markus Biermaier <mbier@eunet.at> writes:
> 
> > I have a problem, when mounting a DOS-File-System with "mount -t vfat":
> > Most (long) file/folder names are corrupted.
> 
> [...]
> 
> > I had sometimes problems with byte-ordering (big endianess) before when
> > I used relatively new modules...
> > 
> > My configuration:
> > 
> > Hardware:	Apple PowerBook G3 (bronze keyboard)
> > System:		SuSE Linux 7.1
> > Kernel:		Self compiled kernel 2.4.12
> 
> Could you please try linux-2.4.13 or later?  IIRC, this bug was fixed
> at linux-2.4.13.
> -- 
> OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
> 

Thank you,

my problem is solved with kernel 2.4.13.


Kind regards

Markus Biermaier

----------------------------------------------------------------------
M. Biermaier                                       Tel: +43-2233-55932
Wiesengasse 15                                   Fax: +43-2233-55932-4
3011  Untertullnerbach                          E-Mail: mbier@EUnet.at
Austria / Europe               Web Site: http://www.mbier.co.at/mbier/

