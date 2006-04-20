Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751025AbWDVTWt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751025AbWDVTWt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Apr 2006 15:22:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751028AbWDVTWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Apr 2006 15:22:49 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:29191 "EHLO
	spitz.ucw.cz") by vger.kernel.org with ESMTP id S1751025AbWDVTWs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Apr 2006 15:22:48 -0400
Date: Thu, 20 Apr 2006 22:04:51 +0000
From: Pavel Machek <pavel@ucw.cz>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Xavier Bestel <xavier.bestel@free.fr>, dtor_core@ameritech.net,
       Matthew Garrett <mjg59@srcf.ucam.org>,
       "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060420220451.GE2352@ucw.cz>
References: <554C5F4C5BA7384EB2B412FD46A3BAD1332980@pdsmsx411.ccr.corp.intel.com> <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <1145549460.23837.156.camel@capoeira> <4447B7D6.4030401@linux.intel.com> <d120d5000604201230y48493995l1bb13d01a8122e11@mail.gmail.com> <1145563624.14595.5.camel@bip.parateam.prv> <44489D58.3090209@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44489D58.3090209@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> >Err .. that's what I meant, sorry I was not clear. 
> >Matthew's solution
> >looks right.
> If there is no ACPI, you don't have ACPI buttons to 
> remap. Remapping power/lid/sleep button is not wise at 
> least, just because you boot once with acpi=off and get 
> unclean shutdown instead of your intended remapped 
> keystroke.

There are many machines that have no ACPI, but have power buttons and
want to use them... and map them. Not all the world is PC.
-- 
Thanks, Sharp!
