Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751149AbWIHUED@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbWIHUED (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Sep 2006 16:04:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751166AbWIHUEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Sep 2006 16:04:01 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:16819 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S1751149AbWIHUEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Sep 2006 16:04:00 -0400
Date: Fri, 8 Sep 2006 20:59:22 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Nigel Cunningham <ncunningham@linuxmail.org>
Cc: Kristen Carlson Accardi <kristen.c.accardi@intel.com>,
       linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
       len.brown@intel.com
Subject: Re: patch [0/2]: acpi: add generic removable drive bay support
Message-ID: <20060908195922.GB17220@srcf.ucam.org>
References: <20060907161305.67804d14.kristen.c.accardi@intel.com> <1157679256.3474.48.camel@nigel.suspend2.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1157679256.3474.48.camel@nigel.suspend2.net>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2006 at 11:34:16AM +1000, Nigel Cunningham wrote:

> Allow me to anticipate a question I'm sure will come: will this play
> well with (say) suspending while docked and resuming undocked?

Most hardware seems to send a bay event on resume.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
