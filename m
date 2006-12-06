Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937596AbWLFUOX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937596AbWLFUOX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 15:14:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937606AbWLFUOW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 15:14:22 -0500
Received: from ns1.suse.de ([195.135.220.2]:48210 "EHLO mx1.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937596AbWLFUOW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 15:14:22 -0500
From: Andi Kleen <ak@suse.de>
To: john stultz <johnstul@us.ibm.com>
Subject: Re: PMTMR running too fast
Date: Wed, 6 Dec 2006 21:14:15 +0100
User-Agent: KMail/1.9.5
Cc: Ian Campbell <ijc@hellion.org.uk>, linux-kernel@vger.kernel.org
References: <1165153834.5499.40.camel@localhost.localdomain> <200612061744.47249.ak@suse.de> <1165433328.6729.18.camel@localhost.localdomain>
In-Reply-To: <1165433328.6729.18.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200612062114.15420.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > I don't think the boot time check needs DMI guarding
> 
> DMI guarding? I'm not following...

DMI guarding = Making it conditional on a DMI check

-Andi
