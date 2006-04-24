Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750759AbWDXMv0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750759AbWDXMv0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Apr 2006 08:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750753AbWDXMv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Apr 2006 08:51:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:60059 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750743AbWDXMvZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Apr 2006 08:51:25 -0400
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: grundig <grundig@teleline.es>
Cc: Crispin Cowan <crispin@novell.com>, ak@suse.de, arjan@infradead.org,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
In-Reply-To: <20060420150001.25eafba0.grundig@teleline.es>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	 <p73mzeh2o38.fsf@bragg.suse.de>
	 <20060420011037.6b2c5891.grundig@teleline.es>
	 <200604200138.00857.ak@suse.de> <4446E4AE.1090901@novell.com>
	 <20060420150001.25eafba0.grundig@teleline.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 24 Apr 2006 14:01:20 +0100
Message-Id: <1145883680.29648.25.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2006-04-20 at 15:00 +0200, grundig wrote:
> Wouldn't have more sense to improve it and then submit it instead of the
> contrary? 

Submitting it is very useful. It allows everyone to see what is involved
in knocking it into shape and to ask useful questions like 'does LSM
need to pass more/differing information'.


