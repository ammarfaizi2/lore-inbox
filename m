Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264248AbTFKJQk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 05:16:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264257AbTFKJQk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 05:16:40 -0400
Received: from lopsy-lu.misterjones.org ([62.4.18.26]:32262 "EHLO
	young-lust.wild-wind.fr.eu.org") by vger.kernel.org with ESMTP
	id S264248AbTFKJQj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 05:16:39 -0400
To: linux-kernel@vger.kernel.org
Cc: debian-alpha@lists.debian.org
Subject: Re: RealTek NIC on alpha?
Organization: Metropolis -- Nowhere
X-Attribution: maz
Reply-to: mzyngier@freesurf.fr
References: <20030611091910.GD801@rene-engelhard.de>
From: Marc Zyngier <mzyngier@freesurf.fr>
Date: Wed, 11 Jun 2003 11:27:42 +0200
Message-ID: <wrpznkp9d69.fsf@hina.wild-wind.fr.eu.org>
In-Reply-To: <20030611091910.GD801@rene-engelhard.de> (Rene Engelhard's
 message of "Wed, 11 Jun 2003 11:19:11 +0200")
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Rene" == Rene Engelhard <rene@rene-engelhard.de> writes:

Rene> 8139too Fast Ethernet driver 0.9.2
Rene> and does not do anything after that.

Make sure CONFIG_8139TOO_PIO is set. I had similar problem on one of
my Multias...

Regards,

        M.
-- 
Places change, faces change. Life is so very strange.
