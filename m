Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262325AbVFIIUS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262325AbVFIIUS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 04:20:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262327AbVFIIUS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 04:20:18 -0400
Received: from web25805.mail.ukl.yahoo.com ([217.12.10.190]:28091 "HELO
	web25805.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262325AbVFIIUM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 04:20:12 -0400
Message-ID: <20050609082003.74895.qmail@web25805.mail.ukl.yahoo.com>
Date: Thu, 9 Jun 2005 10:20:03 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: Advices for a lcd driver design. (suite)
To: Lukasz Stelmach <stlman@poczta.fm>
Cc: Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
In-Reply-To: <42A7489F.10604@poczta.fm>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- Lukasz Stelmach <stlman@poczta.fm> a écrit :
>
> Try to find something in:
> /usr/src/linux/drivers/video/console/fbcon.c
> 

hmm I already looked at it...and I can't find out an answer to my initial
question: can a process which is using a fb console prevent another process
for accessing /dev/fb ?

cheers.

           Francis


	

	
		
_____________________________________________________________________________ 
Découvrez le nouveau Yahoo! Mail : 1 Go d'espace de stockage pour vos mails, photos et vidéos ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com
