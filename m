Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269913AbUJTKmX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269913AbUJTKmX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 06:42:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269896AbUJTKhF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 06:37:05 -0400
Received: from moutng.kundenserver.de ([212.227.126.190]:57068 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S269401AbUJTKfv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 06:35:51 -0400
From: Hans-Peter Jansen <hpj@urpla.net>
To: James Stevenson <james@stev.org>
Subject: Re: ATA/133 Problems with multiple cards
Date: Wed, 20 Oct 2004 12:35:37 +0200
User-Agent: KMail/1.5.4
Cc: <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
       <kernelnewbies@nl.linux.org>
References: <Pine.LNX.4.44.0410170347430.3660-100000@beast.stev.org>
In-Reply-To: <Pine.LNX.4.44.0410170347430.3660-100000@beast.stev.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410201235.37423.hpj@urpla.net>
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:18d01dd0a2a377f0376b761557b5e99a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[Heavily stripped address lists]

On Sunday 17 October 2004 04:51, James Stevenson wrote:
>
> then i can only turn the dma up to ATA/100 if i set it to ata/133
> it will cause the errors. I assume this is something todo with the
> promise bois not setting up the 3rd card at boot time. It only
> shows drive listing for 2 of the 3 cards.

As noted before, this effect was always related to different firmware 
versions on the cards here. Please check boot messages of all cards 
separately, and confirm, that this isn't your problem.

Thanks,
Pete

