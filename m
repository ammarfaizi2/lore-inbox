Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267529AbTAMPRp>; Mon, 13 Jan 2003 10:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267624AbTAMPRp>; Mon, 13 Jan 2003 10:17:45 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:30417 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S267529AbTAMPRp>;
	Mon, 13 Jan 2003 10:17:45 -0500
Date: Mon, 13 Jan 2003 16:26:34 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Ludovic Drolez <ludovic.drolez@freealter.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: BLKBSZSET still not working on 2.4.18 ?
Message-ID: <20030113152634.GA20960@win.tue.nl>
References: <3E1EE7A3.1050401@freealter.com> <20030110161331.GA19942@win.tue.nl> <3E22A2E4.2000604@freealter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E22A2E4.2000604@freealter.com>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 13, 2003 at 12:28:36PM +0100, Ludovic Drolez wrote:

> >You can test 2.5. If it is wrong there I must submit a patch.

> It seems to work perfectly with 2.5.56

Excellent.

> But, I'm still reluctant to use an unstable kernel for backuping a 
> partition. But maybe the 2.5 is stable enough to read blocks from 
> IDE/SCSI drives, and send them over NFSv2 / IPv4 ?

Stable / unstable is not a binary decision. Some things are broken
in 2.4. Many things are broken in 2.5. Still I use 2.5.recent
on a daily basis without meeting bad problems (if I refrain from
inserting and removing USB devices).
Try, and if it works for you, fine.  But no guarantees given.

Andries
