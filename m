Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263088AbTJUNBl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 09:01:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263091AbTJUNBl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 09:01:41 -0400
Received: from poup.poupinou.org ([195.101.94.96]:53801 "EHLO
	poup.poupinou.org") by vger.kernel.org with ESMTP id S263088AbTJUNBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 09:01:41 -0400
Date: Tue, 21 Oct 2003 15:01:36 +0200
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Cc: cpufreq@www.linux.org.uk, linux-kernel@vger.kernel.org,
       linux-acpi <linux-acpi@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       Dominik Brodowski <linux@brodo.de>
Subject: Re: [PATCH] 1/3 Dynamic cpufreq governor and updates to ACPI P-state driver
Message-ID: <20031021130136.GI13989@poupinou.org>
References: <88056F38E9E48644A0F562A38C64FB60077912@scsmsx403.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88056F38E9E48644A0F562A38C64FB60077912@scsmsx403.sc.intel.com>
User-Agent: Mutt/1.5.4i
From: Ducrot Bruno <ducrot@poupinou.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There is already a patch from Dominik Brodowski for the apci p-state which IMHO
is better at least by design.  Your do not handle correctly other processors
than Intel.  But the HT stuff may be interresting, though.

-- 
Ducrot Bruno

--  Which is worse:  ignorance or apathy?
--  Don't know.  Don't care.
