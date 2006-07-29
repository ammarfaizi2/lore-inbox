Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWG2Syw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWG2Syw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 14:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751346AbWG2Syw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 14:54:52 -0400
Received: from cantor2.suse.de ([195.135.220.15]:8920 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751213AbWG2Syv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 14:54:51 -0400
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [patch 2/5] Add the Kconfig option for the stackprotector feature
Date: Sat, 29 Jul 2006 20:50:37 +0200
User-Agent: KMail/1.9.3
Cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
References: <1154102546.6416.9.camel@laptopd505.fenrus.org> <1154102627.6416.13.camel@laptopd505.fenrus.org> <20060729174840.GE26963@stusta.de>
In-Reply-To: <20060729174840.GE26963@stusta.de>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200607292050.37877.ak@suse.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> After reading this thread, I do understand why you write once 
> "GCC version 4.1" and once "gcc version 4.2".
> 
> But for the normal user this will be quite confusing.

Yes it's a mess.

> What about simply removing the first sentence of the help text since 
> it's anyway handled by the NOTE?

It should be obsolete with autoprobing for the feature as earlier discussed.

-Andi
