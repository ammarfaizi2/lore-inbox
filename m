Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932272AbVLMAZj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932272AbVLMAZj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 19:25:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932271AbVLMAZj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 19:25:39 -0500
Received: from mail.dvmed.net ([216.237.124.58]:64710 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932224AbVLMAZi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 19:25:38 -0500
Message-ID: <439E14F0.4040001@pobox.com>
Date: Mon, 12 Dec 2005 19:25:20 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Brown <broonie@sirena.org.uk>
CC: Tim Hockin <thockin@hockin.org>, Francois Romieu <romieu@fr.zoreil.com>,
       netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] natsemi: NAPI support
References: <20051204224734.GA12962@sirena.org.uk> <20051204231209.GA28949@electric-eye.fr.zoreil.com> <20051205232301.GA4551@sirena.org.uk> <20051206001934.GA18329@electric-eye.fr.zoreil.com> <20051206211729.GB3709@sirena.org.uk> <20051206215619.GB3425@electric-eye.fr.zoreil.com> <20051209104832.GA3677@sirena.org.uk> <20051212235531.GB3714@sirena.org.uk>
In-Reply-To: <20051212235531.GB3714@sirena.org.uk>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Mark Brown wrote: > This patch against 2.6.14 converts
	the natsemi driver to use NAPI. It > was originally based on one
	written by Harald Welte, though it has since > been modified quite a
	bit, most extensively in order to remove the > ability to disable NAPI
	since none of the other drivers seem to provide > that functionality
	any more. > > Signed-off-by: Mark Brown <broonie@sirena.org.uk> [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Brown wrote:
> This patch against 2.6.14 converts the natsemi driver to use NAPI.  It
> was originally based on one written by Harald Welte, though it has since
> been modified quite a bit, most extensively in order to remove the
> ability to disable NAPI since none of the other drivers seem to provide
> that functionality any more.
> 
> Signed-off-by: Mark Brown <broonie@sirena.org.uk>

Was it updated per the comments you received on the first posting?

	Jeff



