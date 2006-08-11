Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751078AbWHKEIj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751078AbWHKEIj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 00:08:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbWHKEIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 00:08:39 -0400
Received: from cantor2.suse.de ([195.135.220.15]:14782 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751078AbWHKEIi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 00:08:38 -0400
From: Andi Kleen <ak@suse.de>
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
Subject: Re: [PATCH for review] [133/145] x86_64: Support physical cpu hotplug for x86_64
Date: Fri, 11 Aug 2006 06:05:11 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org
References: <20060810935.775038000@suse.de> <20060810193733.28CA013B8E@wotan.suse.de> <20060810222056.GA24184@mail.muni.cz>
In-Reply-To: <20060810222056.GA24184@mail.muni.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608110605.11794.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Looks like subject or patch is misleading. X86_64 vs arch/i386

No, actually the patch implements it for x86-64 -- the x86-64 code lives
in arch/i386 in this case

-Andi
