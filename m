Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261653AbVBJUL5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261653AbVBJUL5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Feb 2005 15:11:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261695AbVBJUL5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Feb 2005 15:11:57 -0500
Received: from cavan.codon.org.uk ([213.162.118.85]:56042 "EHLO
	cavan.codon.org.uk") by vger.kernel.org with ESMTP id S261653AbVBJUKj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Feb 2005 15:10:39 -0500
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Ville =?ISO-8859-1?Q?Syrj=E4l=E4?= <syrjala@sci.fi>
Cc: Bill Davidsen <davidsen@tmr.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Pavel Machek <pavel@ucw.cz>, Jon Smirl <jonsmirl@gmail.com>,
       ncunningham@linuxmail.org,
       Carl-Daniel Hailfinger <c-d.hailfinger.devel.2005@gmx.net>,
       ACPI List <acpi-devel@lists.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20050210192554.GA15726@sci.fi>
References: <1107695583.14847.167.camel@localhost.localdomain>
	 <420BB267.8060108@tmr.com>  <20050210192554.GA15726@sci.fi>
Date: Thu, 10 Feb 2005 20:08:15 +0000
Message-Id: <1108066096.4085.69.camel@tyrosine>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.3 
X-SA-Exim-Connect-IP: 213.162.118.93
X-SA-Exim-Mail-From: mjg59@srcf.ucam.org
Subject: Re: [RFC] Reliable video POSTing on resume (was: Re: [ACPI]  
	Samsung P35, S3, black screen (radeon))
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on cavan.codon.org.uk)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-02-10 at 21:25 +0200, Ville Syrjälä wrote:
> BTW it seems that old ATI cards use the BIOS to initialize secondary 
> adapters even under Windows.
> See http://www.ati.com/support/infobase/3663.html.

It also explicitly states that Windows 2000 and XP don't support this,
which leads me to suspect that vendors no longer expect POSTing to be
possible after initial system boot.

-- 
Matthew Garrett | mjg59@srcf.ucam.org

