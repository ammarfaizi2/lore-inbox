Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932155AbWFMQB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932155AbWFMQB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 12:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932161AbWFMQB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 12:01:29 -0400
Received: from mga05.intel.com ([192.55.52.89]:4277 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S932155AbWFMQB2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 12:01:28 -0400
X-IronPort-AV: i="4.06,128,1149490800"; 
   d="scan'208"; a="51395443:sNHT2184824425"
Message-ID: <448EE057.6010101@foo-projects.org>
Date: Tue, 13 Jun 2006 08:57:11 -0700
From: Auke Kok <sofar@foo-projects.org>
User-Agent: Mail/News 1.5.0.4 (X11/20060601)
MIME-Version: 1.0
To: Marc Perkel <marc@perkel.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl> <1150189506.11159.93.camel@shinybook.infradead.org> <20060613104557.GA13597@merlin.emma.line.org> <1150201475.12423.12.camel@hades.cambridge.redhat.com> <20060613124944.GA16171@merlin.emma.line.org> <448ED798.2080706@perkel.com>
In-Reply-To: <448ED798.2080706@perkel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Jun 2006 15:57:43.0391 (UTC) FILETIME=[1B181EF0:01C68F02]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Perkel wrote:
> Here's a cheap trick that I use to get rid of a lot of spam. What I do 
> is set my highest MX record to a nonworking IP address. Spammers often 
> start at the highest MX rather than the lowest figuring the highest has 
> less spam filtering. And the spammers never retry. IO get rid of about 
> 120,000 spams a day with this trick.

and this will also get you blacklisted - it is not allowed to have non-working 
or bogus MX records. See http://www.rfc-ignorant.org/policy-bogusmx.php

Auke
