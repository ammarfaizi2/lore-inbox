Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262741AbUKMBmQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262741AbUKMBmQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 20:42:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262751AbUKMBjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 20:39:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:58550 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262688AbUKMBhh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 20:37:37 -0500
Subject: Re: [PATCH] MII bus API for PHY devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jason McMullan <jason.mcmullan@timesys.com>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Jeff Garzik <jgarzik@pobox.com>, romieu@fr.zoreil.com
In-Reply-To: <1100278046.17607.23.camel@jmcmullan>
References: <20041111224845.GA12646@jmcmullan.timesys>
	 <1100240131.20512.47.camel@gaston>  <1100278046.17607.23.camel@jmcmullan>
Content-Type: text/plain
Date: Sat, 13 Nov 2004 12:36:59 +1100
Message-Id: <1100309819.20593.99.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-11-12 at 11:47 -0500, Jason McMullan wrote:

> 	For the 'wake on lan' stuff, could you give me a list of the
> types of features you'd need? I haven't really looked at WOL just yet.

Me neither, though Colin Leroy has, I'll check out his stuff next week.

> 	We can add WOL, suspend, etc. as needed. I just want to
> get the base infrastructure in first, and gradually start migrating
> phys to the mii_bus on embedded systems.
> 
-- 
Benjamin Herrenschmidt <benh@kernel.crashing.org>

