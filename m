Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131474AbRCWWL4>; Fri, 23 Mar 2001 17:11:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131477AbRCWWLt>; Fri, 23 Mar 2001 17:11:49 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:62224 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S131474AbRCWWLc>; Fri, 23 Mar 2001 17:11:32 -0500
Subject: Re: raw access and qlogic isp device driver?
To: mmitchell@eurologic.com (Mark Mitchell)
Date: Fri, 23 Mar 2001 22:13:44 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3ABBA330.2ADCEBAA@eurologic.com> from "Mark Mitchell" at Mar 23, 2001 07:25:36 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gZoY-0005Xy-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Any chance of anyone elaborating on any RAWIO flaws?
> 
> *Seems* to work fine with:
> - 2.4.2 (inc Dave Miller's zero copy patch)
> - qlogic fc driver & qla2200
> - PIII
> - Seagate ST39103fc drives in a JBOD
> 
> I really need to know any *specific* issues with RAWIO.

All I know is that Stephen said he had a set of patches needed to fix rawio.
I've not applied them nor afaik has Linus.

