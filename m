Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWAKWhW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWAKWhW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 17:37:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932394AbWAKWhV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 17:37:21 -0500
Received: from mail.dvmed.net ([216.237.124.58]:10711 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S932306AbWAKWhS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 17:37:18 -0500
Message-ID: <43C58895.4080006@pobox.com>
Date: Wed, 11 Jan 2006 17:37:09 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Daniel Drake <dsd@gentoo.org>
CC: "John W. Linville" <linville@tuxdriver.com>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: Wireless: One small step towards a more perfect union...?
References: <20060106042218.GA18974@havoc.gtf.org> <20060111020534.GA22285@tuxdriver.com> <43C5869A.5080107@gentoo.org>
In-Reply-To: <43C5869A.5080107@gentoo.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.1 (/)
X-Spam-Report: Spam detection software, running on the system "srv2.dvmed.net", has
	identified this incoming email as possible spam.  The original message
	has been attached to this so you can view it (if it isn't spam) or label
	similar future email.  If you have any questions, see
	the administrator of that system for details.
	Content preview:  Daniel Drake wrote: > FWIW, my opinion is that the
	devicescape code should be broken down and > used to extend the
	existing stack, no matter how 'good' it is. The way > it has been
	developed (i.e. totally outside of the ieee80211 stack) is > somewhat
	insulting to our development process. [...] 
	Content analysis details:   (0.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.1 RCVD_IN_SORBS_DUL      RBL: SORBS: sent directly from dynamic IP address
	[69.134.188.146 listed in dnsbl.sorbs.net]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Drake wrote:
> FWIW, my opinion is that the devicescape code should be broken down and 
> used to extend the existing stack, no matter how 'good' it is. The way 
> it has been developed (i.e. totally outside of the ieee80211 stack) is 
> somewhat insulting to our development process.

Strongly agreed, though perhaps some of the blame rests on me for 
letting ieee80211 sit around too long without a clear maintainer...

	Jeff


