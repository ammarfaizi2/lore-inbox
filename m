Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284147AbRLMPUi>; Thu, 13 Dec 2001 10:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284204AbRLMPU3>; Thu, 13 Dec 2001 10:20:29 -0500
Received: from mailgate.bodgit-n-scarper.com ([62.49.233.146]:14856 "HELO
	mould.bodgit-n-scarper.com") by vger.kernel.org with SMTP
	id <S284147AbRLMPUS>; Thu, 13 Dec 2001 10:20:18 -0500
Date: Thu, 13 Dec 2001 15:26:24 +0000
From: Matt <matt@bodgit-n-scarper.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Kernel-2.4.17pre8 & invalidate: busy buffer
Message-ID: <20011213152624.A742@mould.bodgit-n-scarper.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <20011213092908.6764@smtp.wanadoo.fr> <XFMail.20011213124137.ast@domdv.de> <20011213143513.GB1810@sky.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20011213143513.GB1810@sky.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.2.20 on i686 SMP (mould)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 13, 2001 at 03:35:13PM +0100, Ulrich Wiederhold wrote:
> * Andreas Steinmetz <ast@domdv.de> [011213 12:41]:
> > You will see this message with LVM too when issuing vgscan/vgchange.
> > 
> Yes, same here with lvm.
> 
> 2 HD's, no RAID, reiserfs.

I've got LVM and one of said AACRAID adapters. If I do vgscan then I get about
15 copies of the message written, but I haven't been able to trigger it by
accessing the RAID partitions.

Matt
-- 
"Phase plasma rifle in a forty-watt range?"
"Only what you see on the shelves, buddy"
