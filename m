Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750870AbWA0NQh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750870AbWA0NQh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 08:16:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750803AbWA0NQh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 08:16:37 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:59119 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S1750857AbWA0NQg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 08:16:36 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Fri, 27 Jan 2006 14:15:02 +0100
To: Valdis.Kletnieks@vt.edu, schilling@fokus.fraunhofer.de
Cc: rlrevell@joe-job.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, jerome.lacoste@gmail.com,
       acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43DA1CD6.nailFHI6QV3LO@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner>
 <43D7B5BE.60304@gmx.de> <43D89B7C.nailDTH38QZBU@burner>
 <5a2cf1f60601260234r4c5cde3fu3e8d79e816b9f3fd@mail.gmail.com>
 <43D8D69F.nailE2XAJ2XIA@burner>
 <200601270524.k0R5OIS8019541@turing-police.cc.vt.edu>
In-Reply-To: <200601270524.k0R5OIS8019541@turing-police.cc.vt.edu>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Valdis.Kletnieks@vt.edu wrote:

> And you know what? I really don't give a flying <fornicate> in a rolling donut
> what FreeBSD calls the device. If I did, I'd have installed FreeBSD.  But I

It has been mentioned here many times, you only need to read it.

FreeBSD comes with a T-10 (SCSI) compliant CAM interface that uses a multiplex 
device and dev=b,t,l to address the devices. This is true for _all_ kind of 
SCSI devices and thus includes ATAPI transport.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
