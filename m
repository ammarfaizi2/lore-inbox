Return-Path: <linux-kernel-owner+w=401wt.eu-S932914AbWLSTo0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932914AbWLSTo0 (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 14:44:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932922AbWLSTo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 14:44:26 -0500
Received: from cavan.codon.org.uk ([217.147.92.49]:34624 "EHLO
	vavatch.codon.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932914AbWLSToZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 14:44:25 -0500
Date: Tue, 19 Dec 2006 19:44:10 +0000
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, david-b@pacbell.net, gregkh@suse.de
Message-ID: <20061219194410.GA14121@srcf.ucam.org>
References: <20061219185223.GA13256@srcf.ucam.org> <1166556889.3365.1269.camel@laptopd505.fenrus.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1166556889.3365.1269.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
Subject: Re: Changes to sysfs PM layer break userspace
X-SA-Exim-Version: 4.2.1 (built Tue, 20 Jun 2006 01:35:45 +0000)
X-SA-Exim-Scanned: Yes (on vavatch.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 19, 2006 at 08:34:48PM +0100, Arjan van de Ven wrote:

> which userspace is using this btw?

Ubuntu uses it to disable wireless hardware under certain circumstances. 
I believe that Suse's powernowd uses it to power down wired ethernet 
hardware when it's not in use.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
