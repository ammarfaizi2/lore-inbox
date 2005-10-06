Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750880AbVJFOUw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750880AbVJFOUw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Oct 2005 10:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbVJFOUw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Oct 2005 10:20:52 -0400
Received: from relay.uni-heidelberg.de ([129.206.100.212]:27811 "EHLO
	relay.uni-heidelberg.de") by vger.kernel.org with ESMTP
	id S1750877AbVJFOUv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Oct 2005 10:20:51 -0400
Date: Thu, 6 Oct 2005 16:20:39 +0200 (CEST)
From: Bogdan Costescu <Bogdan.Costescu@iwr.uni-heidelberg.de>
To: Brett Russ <russb@emc.com>
cc: Jeff Garzik <jgarzik@pobox.com>, linux-ide@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc2 0/2] libata: Marvell SATA support (v0.23-0.24)
In-Reply-To: <4345273B.40906@emc.com>
Message-ID: <Pine.LNX.4.63.0510061609030.5687@dingo.iwr.uni-heidelberg.de>
References: <20051005210610.EC31826369@lns1058.lss.emc.com>
 <Pine.LNX.4.63.0510061441050.3140@dingo.iwr.uni-heidelberg.de>
 <43452315.7050801@pobox.com> <4345273B.40906@emc.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, Brett Russ wrote:

> No surprise we're seeing so many problems.  I have just not spent 
> any time at all on 5xxx.  Probably should yank it from the pci 
> device table for now.

Fair enough. Given that the register addresses that Jeff mentioned are 
not enough if the register content is different, I'll just wait for 
somebody with documentation to come up with proper code.

... which means that I'll stop testing now, as I only have 5xxx 
controllers. Please specifically mention 5xxx if a new patch starts to 
support them. Thanks again!

-- 
Bogdan Costescu

IWR - Interdisziplinaeres Zentrum fuer Wissenschaftliches Rechnen
Universitaet Heidelberg, INF 368, D-69120 Heidelberg, GERMANY
Telephone: +49 6221 54 8869, Telefax: +49 6221 54 8868
E-mail: Bogdan.Costescu@IWR.Uni-Heidelberg.De
