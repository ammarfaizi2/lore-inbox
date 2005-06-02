Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261563AbVFBBsu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261563AbVFBBsu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 21:48:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261562AbVFBBst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 21:48:49 -0400
Received: from gate.crashing.org ([63.228.1.57]:42439 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261563AbVFBBsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 21:48:32 -0400
Subject: Re: Freezer Patches.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ncunningham@cyclades.com
Cc: Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1117676753.10888.105.camel@localhost>
References: <1117629212.10328.26.camel@localhost>
	 <20050601130205.GA1940@openzaurus.ucw.cz>
	 <1117663709.13830.34.camel@localhost> <20050601223101.GD11163@elf.ucw.cz>
	 <1117665934.19020.94.camel@gaston>  <20050601230235.GF11163@elf.ucw.cz>
	 <1117676753.10888.105.camel@localhost>
Content-Type: text/plain
Date: Thu, 02 Jun 2005 11:48:04 +1000
Message-Id: <1117676884.31082.2.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Again, try it under load... and stop talking about fork and exit like
> they're real hot paths. (Unless you regularly submit your machines to
> fork bombs :)).

They are real hot path

Ben.


