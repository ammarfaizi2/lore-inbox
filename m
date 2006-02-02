Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423421AbWBBJoM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423421AbWBBJoM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Feb 2006 04:44:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423422AbWBBJoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Feb 2006 04:44:12 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:53499 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1423421AbWBBJoK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Feb 2006 04:44:10 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 02 Feb 2006 10:42:47 +0100
To: schilling@fokus.fraunhofer.de, jengelh@linux01.gwdg.de
Cc: mrmacman_g4@mac.com, mj@ucw.cz, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, James@superbug.co.uk, j@bitron.ch,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43E1D417.nail4MI11WTFI@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner>
 <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <43DDFBFF.nail16Z3N3C0M@burner>
 <1138642683.7404.31.camel@juerg-pd.bitron.ch>
 <43DF3C3A.nail2RF112LAB@burner>
 <mj+md-20060131.104748.24740.atrey@ucw.cz>
 <43DF65C8.nail3B41650J9@burner>
 <Pine.LNX.4.61.0602011612520.22529@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0602011612520.22529@yvahk01.tjqt.qr>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:

> It's shorter than /dev/c0t0d0s0? Well, I think it's because people think 
> in terms of connectors (my drive is IDE therefore it must be hdc) rather 
> than protocol (my drive does ATAPI therefore it must be 
> /dev/scsi/c0t0d0s0).

Is there any reason why the people with small PCs should dominate the 
people with big machines?

If you use /dev/hd*, you loose control after you add more than ~ 6-10 disks.

The systematical attempt is easy to remember even with a big amount of 
external hardware.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
