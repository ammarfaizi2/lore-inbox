Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277300AbRJJQWl>; Wed, 10 Oct 2001 12:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277303AbRJJQWa>; Wed, 10 Oct 2001 12:22:30 -0400
Received: from mail.scsiguy.com ([63.229.232.106]:29202 "EHLO
	aslan.scsiguy.com") by vger.kernel.org with ESMTP
	id <S277300AbRJJQW0>; Wed, 10 Oct 2001 12:22:26 -0400
Message-Id: <200110101622.f9AGMrY82571@aslan.scsiguy.com>
To: Alexander Feigl <Alexander.Feigl@gmx.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: aic7xxx SCSI system hangs 
In-Reply-To: Your message of "Wed, 10 Oct 2001 16:03:12 +0200."
             <200110101403.f9AE3DY6006854@PowerBox.MysticWorld.de> 
Date: Wed, 10 Oct 2001 10:22:53 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Summary : aic7xxx SCSI system hangs 

You need to send a complete console log from boot through the hang
(serial console preferred).  It would also be userfull for you to
add KDB to your system and get as much information about the hung
exception handling thread (e.g. what routines it is looping through).

--
Justin
