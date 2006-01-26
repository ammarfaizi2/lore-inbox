Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932316AbWAZOEK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932316AbWAZOEK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Jan 2006 09:04:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932319AbWAZOEK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Jan 2006 09:04:10 -0500
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:31978 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S932316AbWAZOEJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Jan 2006 09:04:09 -0500
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Thu, 26 Jan 2006 15:03:11 +0100
To: schilling@fokus.fraunhofer.de, jerome.lacoste@gmail.com
Cc: rlrevell@joe-job.com, mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Message-ID: <43D8D69F.nailE2XAJ2XIA@burner>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner>
 <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B075.6000602@gmx.de> <43D7B2DF.nailDFJA51SL1@burner>
 <43D7B5BE.60304@gmx.de> <43D89B7C.nailDTH38QZBU@burner>
 <5a2cf1f60601260234r4c5cde3fu3e8d79e816b9f3fd@mail.gmail.com>
In-Reply-To: <5a2cf1f60601260234r4c5cde3fu3e8d79e816b9f3fd@mail.gmail.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jerome lacoste <jerome.lacoste@gmail.com> wrote:


> As a Linux user, the only reason I do cdrecord -scanbus is to comply
> to the cdrecord way of doing likes. I don't personally like it.
>
> I'd rather use /dev/cdrw, in a machine independent way, as in:
>
>   ssh user@host cdrecord dev=/dev/cdrw /path/to/file.iso

On the vast majority of OS this does not work.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de                (uni)  
       schilling@fokus.fraunhofer.de     (work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
