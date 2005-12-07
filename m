Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751049AbVLGNPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751049AbVLGNPE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 08:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVLGNPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 08:15:04 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:34274 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751038AbVLGNPB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 08:15:01 -0500
Date: Wed, 7 Dec 2005 13:14:54 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Shaohua Li <shaohua.li@intel.com>, linux-ide <linux-ide@vger.kernel.org>,
       lkml <linux-kernel@vger.kernel.org>, pavel <pavel@ucw.cz>,
       Len Brown <len.brown@intel.com>, akpm <akpm@osdl.org>
Subject: Re: [RFC]add ACPI hooks for IDE suspend/resume
Message-ID: <20051207131454.GA16558@srcf.ucam.org>
References: <1133849404.3026.10.camel@sli10-mobl.sh.intel.com> <20051206222001.GA14171@srcf.ucam.org> <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <58cb370e0512070017u606ee22fse207b9a859856dd4@mail.gmail.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 07, 2005 at 09:17:31AM +0100, Bartlomiej Zolnierkiewicz wrote:

> Isn't ide-io.c:ide_{start,complete}_power_step() enough?

No.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
