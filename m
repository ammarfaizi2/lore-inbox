Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932187AbVHMQll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932187AbVHMQll (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 12:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932194AbVHMQll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 12:41:41 -0400
Received: from mail.dvmed.net ([216.237.124.58]:37808 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932187AbVHMQlk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 12:41:40 -0400
Message-ID: <42FE22BD.3050804@pobox.com>
Date: Sat, 13 Aug 2005 12:41:33 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Coady <Grant.Coady@gmail.com>
CC: Karsten Wiese <annabellesgarden@yahoo.de>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH,RFC] quirks for VIA VT8237 southbridge
References: <200508131710.38569.annabellesgarden@yahoo.de> <d86sf15b5b36ta7rgkjo2p980fku9e0lce@4ax.com>
In-Reply-To: <d86sf15b5b36ta7rgkjo2p980fku9e0lce@4ax.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Coady wrote:
> I'm tracking a dataloss on box with this chip, finding it difficult 
> to nail a configuration that reliably produces dataloss, sometimes 
> only one bit (e.g. 'c' --> 'C') of unpacking kernel source tree gets 
> changed.


I've been watching this thread in the background.

Just to eliminate one possibility, I would definitely switch out SATA 
cables, which are notoriously crappy.

	Jeff


