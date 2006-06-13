Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932136AbWFMPTy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932136AbWFMPTy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 11:19:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbWFMPTy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 11:19:54 -0400
Received: from 8.ctyme.com ([69.50.231.8]:39555 "EHLO darwin.ctyme.com")
	by vger.kernel.org with ESMTP id S932136AbWFMPTx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 11:19:53 -0400
Message-ID: <448ED798.2080706@perkel.com>
Date: Tue, 13 Jun 2006 08:19:52 -0700
From: Marc Perkel <marc@perkel.com>
User-Agent: Thunderbird 1.5.0.4 (Windows/20060516)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: VGER does gradual SPF activation (FAQ matter)
References: <200606130300.k5D302rc004233@laptop11.inf.utfsm.cl> <1150189506.11159.93.camel@shinybook.infradead.org> <20060613104557.GA13597@merlin.emma.line.org> <1150201475.12423.12.camel@hades.cambridge.redhat.com> <20060613124944.GA16171@merlin.emma.line.org>
In-Reply-To: <20060613124944.GA16171@merlin.emma.line.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here's a cheap trick that I use to get rid of a lot of spam. What I do 
is set my highest MX record to a nonworking IP address. Spammers often 
start at the highest MX rather than the lowest figuring the highest has 
less spam filtering. And the spammers never retry. IO get rid of about 
120,000 spams a day with this trick.
