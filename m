Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266519AbUHIMWb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266519AbUHIMWb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 08:22:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266509AbUHIMHw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 08:07:52 -0400
Received: from mx2.magma.ca ([206.191.0.250]:19683 "EHLO mx2.magma.ca")
	by vger.kernel.org with ESMTP id S266514AbUHIMHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 08:07:38 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Jesse Stockall <stockall@magma.ca>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: axboe@suse.de, James.Bottomley@steeleye.com, linux-kernel@vger.kernel.org
In-Reply-To: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
References: <200408091013.i79ADQK0008995@burner.fokus.fraunhofer.de>
Content-Type: text/plain
Message-Id: <1092053162.8168.9.camel@homer.blizzard.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Mon, 09 Aug 2004 08:06:02 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-09 at 06:13, Joerg Schilling wrote:
> 
> You should learn what "make sense" means, Linux-2.6 is a clear move away from 
> the demands of a Linux user who likes to write CDs/DVDs.

Hmmm, as a Linux user who had been fighting with scsi emulation and
cdecord --scanbus for years, being able to use dev=/dev/hda is so much
easier and so much more in tune with the way the rest of Linux works. 

If you don't believe me, spend some time on irc channels like #gentoo or
#debian where people like me (and many others) give support to Linux and
cdrecord users from all over the world.

Jesse 

-- 
Jesse Stockall <stockall@magma.ca>

