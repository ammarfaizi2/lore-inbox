Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282348AbRLDHYm>; Tue, 4 Dec 2001 02:24:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282317AbRLDHYc>; Tue, 4 Dec 2001 02:24:32 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:52240 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S282283AbRLDHYO>; Tue, 4 Dec 2001 02:24:14 -0500
To: Markus Biermaier <mbier@eunet.at>
Cc: linux-kernel@vger.kernel.org, mayfield+usb@sackheads.org
Subject: Re: Problem with 'mount -t vfat' on PPC
In-Reply-To: <Pine.LNX.4.21.0112031818220.10327-100000@linuxpb.mboffice>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Tue, 04 Dec 2001 16:23:39 +0900
In-Reply-To: <Pine.LNX.4.21.0112031818220.10327-100000@linuxpb.mboffice>
Message-ID: <87zo4zla84.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Markus Biermaier <mbier@eunet.at> writes:

> I have a problem, when mounting a DOS-File-System with "mount -t vfat":
> Most (long) file/folder names are corrupted.

[...]

> I had sometimes problems with byte-ordering (big endianess) before when
> I used relatively new modules...
> 
> My configuration:
> 
> Hardware:	Apple PowerBook G3 (bronze keyboard)
> System:		SuSE Linux 7.1
> Kernel:		Self compiled kernel 2.4.12

Could you please try linux-2.4.13 or later?  IIRC, this bug was fixed
at linux-2.4.13.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
