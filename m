Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131219AbRDEA0b>; Wed, 4 Apr 2001 20:26:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131878AbRDEA0W>; Wed, 4 Apr 2001 20:26:22 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:6161 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131219AbRDEA0J>; Wed, 4 Apr 2001 20:26:09 -0400
Subject: Re: Contacts within AMD?  AMD-756 USB host-controller blacklisted dueto
To: ted@cypress.com (Thomas Dodd)
Date: Thu, 5 Apr 2001 01:27:00 +0100 (BST)
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net (David Brownell),
        alan@lxorguk.ukuu.org.uk (Alan Cox)
In-Reply-To: <3ACBB763.DC728EA3@cypress.com> from "Thomas Dodd" at Apr 04, 2001 07:08:03 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14kxc7-00035S-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Comprimise?
> 
> This patch make it a config option to enable the AMD-756.
> It's marked DANGEROUS and EXPERIMENTAL, and is only
> available if CONFIG_EXPERIMENTAL is set.

Since we expect to get errata docs very soon Im not that worried. As an 
implementation I'd rather a module option of 'ignore_blacklist' or similar
so that it is runtime

