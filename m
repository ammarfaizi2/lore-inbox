Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751651AbWD1RqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751651AbWD1RqK (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 13:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751666AbWD1RqK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 13:46:10 -0400
Received: from cantor2.suse.de ([195.135.220.15]:10978 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751577AbWD1RqI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 13:46:08 -0400
Date: Fri, 28 Apr 2006 19:43:57 +0200
From: Stefan Seyfried <seife@suse.de>
To: Alexey Starikovskiy <alexey_y_starikovskiy@linux.intel.com>
Cc: Martin Mares <mj@ucw.cz>, Matthew Garrett <mjg59@srcf.ucam.org>,
       "Yu, Luming" <luming.yu@intel.com>, linux-acpi@vger.kernel.org,
       linux-kernel@vger.kernel.org, pavel@suse.cz
Subject: Re: [RFC] [PATCH] Make ACPI button driver an input device
Message-ID: <20060428174357.GA16838@suse.de>
References: <20060420073713.GA25735@srcf.ucam.org> <4447AA59.8010300@linux.intel.com> <20060420153848.GA29726@srcf.ucam.org> <4447AF4D.7030507@linux.intel.com> <mj+md-20060420.165714.18107.albireo@ucw.cz> <4447C020.3010003@linux.intel.com> <20060420220731.GF2352@ucw.cz> <444C761F.6010603@linux.intel.com> <20060424083102.GE26345@elf.ucw.cz> <444CE310.7030006@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <444CE310.7030006@linux.intel.com>
X-Operating-System: SUSE LINUX 10.1 (i586), Kernel 2.6.16.9-6-default
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 24, 2006 at 06:39:12PM +0400, Alexey Starikovskiy wrote:
> Any new machine will have this same functionality if booted with 
> acpi=off,ht etc, and this is done automatically on recent SUSE installs.

I am doing many "recent SUSE" installs and have not seen one where a
acpi=.. line was present without the user doing something strange.
-- 
Stefan Seyfried                  \ "I didn't want to write for pay. I
QA / R&D Team Mobile Devices      \ wanted to be paid for what I write."
SUSE LINUX Products GmbH, Nürnberg \                    -- Leonard Cohen
