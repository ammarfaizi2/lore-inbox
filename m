Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbVEIPUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbVEIPUJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 11:20:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261411AbVEIPUG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 11:20:06 -0400
Received: from web25102.mail.ukl.yahoo.com ([217.12.10.50]:1180 "HELO
	web25102.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261416AbVEIPTv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 11:19:51 -0400
Message-ID: <20050509151942.90582.qmail@web25102.mail.ukl.yahoo.com>
Date: Mon, 9 May 2005 17:19:42 +0200 (CEST)
From: moreau francis <francis_moreau2000@yahoo.fr>
Subject: Re: advices for a lcd driver design.
To: Willy Tarreau <willy@w.ods.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Willy

--- Willy Tarreau <willy@w.ods.org> a écrit:
> Hi Francis,
> 
> There already are several drivers for this display, why write another one ?
> One I use and know (because I wrote it :-)) is available here :

sorry I wasn't clear in my last email, when I said 'HD44780 compatible display'
I was talking about electrical signals compatibity.
Actually I will use a lcd that supports graphical or text (80x20) mode. 
I assume that a design for this kind of lcd is different from hd44780's one. 
And that's the reason I want to use kernel vc...

        Francis



	

	
		
__________________________________________________________________
Découvrez le nouveau Yahoo! Mail : 250 Mo d'espace de stockage pour vos mails ! 
Créez votre Yahoo! Mail sur http://fr.mail.yahoo.com/
