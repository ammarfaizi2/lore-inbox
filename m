Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750845AbWDTNAf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750845AbWDTNAf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 09:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750886AbWDTNAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 09:00:35 -0400
Received: from webmail.terra.es ([213.4.149.12]:35984 "EHLO
	csmtpout4.frontal.correo") by vger.kernel.org with ESMTP
	id S1750843AbWDTNAe convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 09:00:34 -0400
Date: Thu, 20 Apr 2006 15:00:58 +0200 (added by postmaster@terra.es)
From: grundig <grundig@teleline.es>
To: Crispin Cowan <crispin@novell.com>
Cc: ak@suse.de, grundig@teleline.es, arjan@infradead.org,
       linux-kernel@vger.kernel.org, chrisw@sous-sol.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-Id: <20060420150001.25eafba0.grundig@teleline.es>
In-Reply-To: <4446E4AE.1090901@novell.com>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com>
	<p73mzeh2o38.fsf@bragg.suse.de>
	<20060420011037.6b2c5891.grundig@teleline.es>
	<200604200138.00857.ak@suse.de>
	<4446E4AE.1090901@novell.com>
X-Mailer: Sylpheed version 2.2.4 (GTK+ 2.8.16; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

El Wed, 19 Apr 2006 18:32:30 -0700,
Crispin Cowan <crispin@novell.com> escribió:

> Our controls on changing the name space have rather poor granularity at
> the moment. We hope to improve that over time, and especially if LSM
> evolves to permit it. This is ok, because as Andi pointed out, there are
> currently few applications using name spaces, so we have time to improve
> the granularity.

Wouldn't have more sense to improve it and then submit it instead of the
contrary? At least is the rule which AFAIK is applied to every feature 
going in the kernel, specially when there's an available alternative
which users can use meanwhile (see reiser4...)
