Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261286AbTBNQel>; Fri, 14 Feb 2003 11:34:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261354AbTBNQel>; Fri, 14 Feb 2003 11:34:41 -0500
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:26846 "EHLO
	crisis.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id <S261286AbTBNQek>; Fri, 14 Feb 2003 11:34:40 -0500
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
Cc: James Bottomley <James.Bottomley@steeleye.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] EISA/sysfs update
References: <1044241767.3924.14.camel@mulgrave>
	<wrp3cmrrwuf.fsf@hina.wild-wind.fr.eu.org>
	<20030214173217.A17730@jurassic.park.msu.ru>
	<wrpisvmri71.fsf@hina.wild-wind.fr.eu.org>
	<20030214190538.A19355@jurassic.park.msu.ru>
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: 14 Feb 2003 17:42:58 +0100
Message-ID: <wrp7kc2rey5.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030214190538.A19355@jurassic.park.msu.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Ivan" == Ivan Kokshaysky <ink@jurassic.park.msu.ru> writes:

Ivan> We have this code in arch/alpha/kernel/pci.c for ages:

[...]

Ivan> I think it belongs in drivers/pci/quirks.c.

Indeed, this would be a good thing for x86 boxes.

Ivan> Actually I thought of replacing "i82375" with "pci_eisa" everywhere
Ivan> in your driver and

[..]

Ok, I'll update the patch tonight, and will repost it.

Thanks,

        M.
-- 
Places change, faces change. Life is so very strange.
