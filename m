Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVBNXZn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVBNXZn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Feb 2005 18:25:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVBNXZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Feb 2005 18:25:39 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:680 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261259AbVBNXZF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Feb 2005 18:25:05 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@suse.cz>
Cc: ACPI mailing list <acpi-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>, seife@suse.de, rjw@sisk.pl
In-Reply-To: <20050214211105.GA12808@elf.ucw.cz>
References: <20050214211105.GA12808@elf.ucw.cz>
Date: Mon, 14 Feb 2005 23:23:59 +0000
Message-Id: <1108423439.4085.121.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [ACPI] Call for help: list of machines with working S3
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-02-14 at 22:11 +0100, Pavel Machek wrote:
> Hi!
> 
> Stefan provided me initial list of machines where S3 works (including
> video). If you have machine that is not on the list, please send me a
> diff. If you have eMachines... I'd like you to try playing with
> vbetool (it worked for me), and if it works for you supplying right
> model numbers.

http://www.ubuntulinux.org/wiki/HoaryPMTesting has a list of several
working machines. HP seem to be the worst supported at the moment.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

