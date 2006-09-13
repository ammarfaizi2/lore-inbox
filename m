Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750868AbWIMOXs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750868AbWIMOXs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 10:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750865AbWIMOXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 10:23:47 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:50050 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750863AbWIMOXq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 10:23:46 -0400
Subject: Re: PROBLEM: (libata) cdrom drive not detected in -mm series
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tejun Heo <htejun@gmail.com>
Cc: "Nelson A. de Oliveira" <naoliv@gmail.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
In-Reply-To: <20060913133743.GF21866@htj.dyndns.org>
References: <9bfa9ae0609111802o9131e8bg6c5d394ad87b16ea@mail.gmail.com>
	 <450664C7.3000105@gmail.com>
	 <9bfa9ae0609120430g7d557c8ds3fe802e1ddfffb27@mail.gmail.com>
	 <20060913133743.GF21866@htj.dyndns.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 13 Sep 2006 15:45:32 +0100
Message-Id: <1158158732.13977.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-09-13 am 22:37 +0900, ysgrifennodd Tejun Heo:
> [adding Alan to this thread]
> 
> The whole thread can be read from

Looks sensible. I didn't consider that case because in the PATA world
nothing is quite that deranged. 


