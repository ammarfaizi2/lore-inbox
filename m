Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWG0OFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWG0OFu (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 10:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751323AbWG0OFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 10:05:50 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:6545 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751311AbWG0OFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 10:05:49 -0400
Date: Thu, 27 Jul 2006 15:05:39 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@suse.cz>
Cc: vojtech@suse.cz, Len Brown <len.brown@intel.com>,
       kernel list <linux-kernel@vger.kernel.org>,
       linux-thinkpad@linux-thinkpad.org, multinymous@gmail.com
Subject: Re: Generic battery interface
Message-ID: <20060727140539.GA10835@srcf.ucam.org>
References: <20060727002035.GA2896@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060727002035.GA2896@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This would also be useful for the OLPC project - it's unlikely that 
it'll use ACPI, but a more feature-rich interface than /proc/apm would 
be massively helpful. This is just a matter of speccing out what 
information is needed and what format it should be presented in, and 
then adding a new device class, right?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
