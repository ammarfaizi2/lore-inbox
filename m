Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031396AbWKUUYM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031396AbWKUUYM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031397AbWKUUYL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:24:11 -0500
Received: from cantor.suse.de ([195.135.220.2]:18921 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1031396AbWKUUYJ (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:24:09 -0500
From: Andi Kleen <ak@suse.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] x86_64 __setup_APIC_LVTT(): remove unused variable
Date: Tue, 21 Nov 2006 21:23:57 +0100
User-Agent: KMail/1.9.5
Cc: d binderman <dcb314@hotmail.com>, Linux-Kernel@vger.kernel.org,
       discuss@x86-64.org, mingo@redhat.com
References: <BAY107-F214E963C5A93489762562E9CEC0@phx.gbl> <20061121202046.GL5200@stusta.de>
In-Reply-To: <20061121202046.GL5200@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611212123.57418.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> This patch removes a variable that whose usage was removed some time ago 
> by Andi.

Thanks.

I already got the similar patch from David Rientjes. 
-Andi
