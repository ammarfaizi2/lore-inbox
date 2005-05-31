Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261866AbVEaLUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261866AbVEaLUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 May 2005 07:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261867AbVEaLUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 May 2005 07:20:21 -0400
Received: from mailhub.fokus.fraunhofer.de ([193.174.154.14]:25556 "EHLO
	mailhub.fokus.fraunhofer.de") by vger.kernel.org with ESMTP
	id S261866AbVEaLUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 May 2005 07:20:12 -0400
From: Joerg Schilling <schilling@fokus.fraunhofer.de>
Date: Tue, 31 May 2005 13:17:57 +0200
To: schilling@fokus.fraunhofer.de, ltd@cisco.com, dtor_core@ameritech.net
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org, 7eggert@gmx.de
Subject: Re: OT] Joerg Schilling flames Linux on his Blog
Message-ID: <429C47E5.nail5X04XI2PP@burner>
References: <26A66BC731DAB741837AF6B2E29C10171E6158@xmb-hkg-413.apac.cisco.com>
In-Reply-To: <26A66BC731DAB741837AF6B2E29C10171E6158@xmb-hkg-413.apac.cisco.com>
User-Agent: nail 11.2 8/15/04
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Let me give up here :-(
> > 
> > If you don't understand that the availability of the device 
> > serial number is not a basic SCSI feature, it makes no sense 
> > to continue this discussion.
>
> bzzt.
>
> oh but it IS a standard SCSI feature.  unit serial number is part of the
> VPD page 80h.
> Multipathing software for FC HBAs have made use of this for quite a
> while now.
>
> (ok, we're quibbling here - its OPTIONAL for a device to support this -
> but i can go back ~7 years of SCSI/FC devices i have here and all
> devices i've found do return this...).

OK, if you understand the meaning of the word optional, then you should
know that any example drive that does support is is absolutely no
evidence for general availability.

If you did test enough different drives, you would know that the chance
is less than 50% for beeing able to retrieve the serial number via SCSI.

Jörg

-- 
 EMail:joerg@schily.isdn.cs.tu-berlin.de (home) Jörg Schilling D-13353 Berlin
       js@cs.tu-berlin.de		(uni)  
       schilling@fokus.fraunhofer.de	(work) Blog: http://schily.blogspot.com/
 URL:  http://cdrecord.berlios.de/old/private/ ftp://ftp.berlios.de/pub/schily
