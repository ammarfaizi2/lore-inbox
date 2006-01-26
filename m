Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932264AbWAZTvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWAZTvy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 14:51:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751392AbWAZTvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 14:51:54 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:26588 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751389AbWAZTvx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 14:51:53 -0500
Date: Thu, 26 Jan 2006 20:51:42 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: dtor_core@ameritech.net, Olivier Galibert <galibert@pobox.com>,
       linux-kernel@vger.kernel.org
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <20060126192409.GC10332@suse.cz>
Message-ID: <Pine.LNX.4.61.0601262050520.322@yvahk01.tjqt.qr>
References: <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com> <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org> <43D8C04F.nailE1C2X9KNC@burner>
 <20060126161028.GA8099@suse.cz> <20060126175506.GA32972@dspnet.fr.eu.org>
 <20060126181034.GA9694@suse.cz> <20060126182818.GA44822@dspnet.fr.eu.org>
 <Pine.LNX.4.61.0601261938180.14581@yvahk01.tjqt.qr>
 <d120d5000601261107t44320a91hd1cec82f7eebd38@mail.gmail.com>
 <20060126192409.GC10332@suse.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>I don't think there is a reason for a new class. Maybe some attributes,
>but not a class - they're all the same kind of devices, only plain
>CD-ROMs can only write CDs at speed 0 ;).

CDROMs incapable of handling unknown media sometimes try to spin them with 
insane speed, so +Inf would be more accurate. ^_^


Jan Engelhardt
-- 
