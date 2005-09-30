Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932267AbVI3ILJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932267AbVI3ILJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 04:11:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932443AbVI3ILJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 04:11:09 -0400
Received: from cantor2.suse.de ([195.135.220.15]:37000 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932267AbVI3ILH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 04:11:07 -0400
From: Andi Kleen <ak@suse.de>
To: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: Re: [Patch] x86, x86_64: fix cpu model for family 0x6
Date: Fri, 30 Sep 2005 10:11:08 +0200
User-Agent: KMail/1.8.2
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
References: <20050929190419.C15943@unix-os.sc.intel.com>
In-Reply-To: <20050929190419.C15943@unix-os.sc.intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509301011.09065.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 30 September 2005 04:04, Siddha, Suresh B wrote:

> According to cpuid instruction in IA32 SDM-Vol2, when computing cpu model,
> we need to consider extended model ID for family 0x6 also.

I'm confused. Is there any 64bit capable CPU with family == 6? 

-Andi
