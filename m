Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279502AbRKMVzg>; Tue, 13 Nov 2001 16:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279462AbRKMVza>; Tue, 13 Nov 2001 16:55:30 -0500
Received: from cisco7500-mainGW.gts.cz ([194.213.32.131]:63874 "EHLO
	Elf.ucw.cz") by vger.kernel.org with ESMTP id <S279416AbRKMVzI>;
	Tue, 13 Nov 2001 16:55:08 -0500
Date: Tue, 13 Nov 2001 01:07:02 +0000
From: Pavel Machek <pavel@suse.cz>
To: Borsenkow Andrej <Andrej.Borsenkow@mow.siemens.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: STR with APM possible?
Message-ID: <20011113010702.A37@toy.ucw.cz>
In-Reply-To: <001101c16b461c9ca95@mow.siemens.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <001101c16b461c9ca95@mow.siemens.ru>; from Andrej.Borsenkow@mow.siemens.ru on Mon, Nov 12, 2001 at 09:55:21AM +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I have ASUS CUSL2 motherboard that supports STR (and it works perfectly
> under windows). With the same BIOS settings doing apm --suspend almost
> suspends - except that power supply fan continues to run, which
> indicates, system is not in STR state.

> Kernel is Mandrake cooker 2.4.13-4mdk (based on -ac6), but it was true
> for all kernels I've tried starting from 2.2.19
> 
> ACPI is not included in mandrake kernels.
> 
> Is it supported? Anything I can do to debug/fix it?

ACPI does not yet quite support suspend-to-ram. Wait awhile.

-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

