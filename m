Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750792AbWHGQHY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750792AbWHGQHY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 12:07:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750791AbWHGQHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 12:07:24 -0400
Received: from ns1.suse.de ([195.135.220.2]:37542 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1750789AbWHGQHX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 12:07:23 -0400
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [-mm patch] make arch/i386/kernel/acpi/boot.c:acpi_force static
Date: Mon, 7 Aug 2006 18:07:16 +0200
User-Agent: KMail/1.9.3
Cc: Andrew Morton <akpm@osdl.org>, Rusty Russell <rusty@rustcorp.com.au>,
       linux-kernel@vger.kernel.org, len.brown@intel.com,
       linux-acpi@vger.kernel.org
References: <20060806030809.2cfb0b1e.akpm@osdl.org> <20060807154938.GC3691@stusta.de>
In-Reply-To: <20060807154938.GC3691@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608071807.16124.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 August 2006 17:49, Adrian Bunk wrote:
> acpi_force can become static.

Both patches added thanks

-Andi
