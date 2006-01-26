Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932384AbWAZSry@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932384AbWAZSry (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 13:47:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932400AbWAZSry
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 13:47:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:32697 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932402AbWAZSru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 13:47:50 -0500
Date: Thu, 26 Jan 2006 19:47:45 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
cc: matthias.andree@gmx.de, grundig@teleline.es, linux-kernel@vger.kernel.org,
       axboe@suse.de, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43D8D50D.nailE2X5WK8ZO@burner>
Message-ID: <Pine.LNX.4.61.0601261945310.14581@yvahk01.tjqt.qr>
References: <20060125144543.GY4212@suse.de> <Pine.LNX.4.61.0601251606530.14438@yvahk01.tjqt.qr>
 <20060125153057.GG4212@suse.de> <43D7AF56.nailDFJ882IWI@burner>
 <20060125181847.b8ca4ceb.grundig@teleline.es> <20060125173127.GR4212@suse.de>
 <43D7C1DF.1070606@gmx.de> <20060125182552.GB4212@suse.de>
 <20060125231422.GB2137@merlin.emma.line.org> <20060126020951.14ebc188.grundig@teleline.es>
 <20060126082324.GB13125@merlin.emma.line.org> <43D8D50D.nailE2X5WK8ZO@burner>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1283855629-1431162210-1138301265=:14581"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1283855629-1431162210-1138301265=:14581
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

>> This sounds like a huge difference, but I don't believe it actually is.
>> Jörg is trying to fight the system rather than stop complaining to users
>> about their using /dev/hd*. The scanning code is there and can be made
>> working with little effort probably.
>
>Talking about /dev/hd* ignore the basic problem. Show me a way how to
>send SCSI commands to a ATAPI tape drive on Linux. 

ATAPI tapes writing CDs (or tapes for that amtter). It may seem possible if 
the scsi command is the same.
Feels like making tea in a coffee machine, but hey, it's possible,
and sounds like Someone want's to have it. :)

>Please do not forget that libscg is OS _and_ device independent.

If so, how much effort is there in having libscg building an enumeration 
out of all (related to cd writing) sysfs drives?


Jan Engelhardt
-- 
--1283855629-1431162210-1138301265=:14581--
