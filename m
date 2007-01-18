Return-Path: <linux-kernel-owner+w=401wt.eu-S932220AbXARMb0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932220AbXARMb0 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 18 Jan 2007 07:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932228AbXARMb0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Jan 2007 07:31:26 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:58035 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932220AbXARMbZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Jan 2007 07:31:25 -0500
Date: Thu, 18 Jan 2007 13:30:27 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Kasper Sandberg <lkml@metanurb.dk>
cc: condor@stz-bg.com, linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: writting files > 100 MB in FAT32
In-Reply-To: <1169123236.12968.6.camel@localhost>
Message-ID: <Pine.LNX.4.61.0701181330160.19740@yvahk01.tjqt.qr>
References: <48247.82.103.71.18.1169112129.squirrel@mail.stz-bg.com>
 <1169123236.12968.6.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>> Hello,
>> 
>> [1.] Files if > 100 MB saving in USB memory stick 4 GB with FAT32. While
>> saving all files is broken.
>im sorry, i do not understand this.
>
>you are saying that if you copy files larger than 100mb into drive, all
>files die?

Then it's probably time to run scandisk or fsck.vfat.

