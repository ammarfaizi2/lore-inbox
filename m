Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261158AbVALMYD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261158AbVALMYD (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Jan 2005 07:24:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261164AbVALMYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Jan 2005 07:24:03 -0500
Received: from mail.enyo.de ([212.9.189.167]:60891 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S261158AbVALMYB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Jan 2005 07:24:01 -0500
From: Florian Weimer <fw@deneb.enyo.de>
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Chris Wright <chrisw@osdl.org>, Steve Bergman <steve@rueb.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Proper procedure for reporting possible security vulnerabilities?
References: <41E2B181.3060009@rueb.com> <87d5wdhsxo.fsf@deneb.enyo.de>
	<41E2F6B3.9060008@rueb.com>
	<Pine.LNX.4.61.0501102309270.2987@dragon.hygekrogen.localhost>
	<20050110164001.Q469@build.pdx.osdl.net>
	<Pine.LNX.4.61.0501111758290.3368@dragon.hygekrogen.localhost>
Date: Wed, 12 Jan 2005 13:23:54 +0100
In-Reply-To: <Pine.LNX.4.61.0501111758290.3368@dragon.hygekrogen.localhost>
	(Jesper Juhl's message of "Tue, 11 Jan 2005 18:05:05 +0100 (CET)")
Message-ID: <87pt0aomxx.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Jesper Juhl:

> Problem is that the info can then get stuck at a vendor or maintainer 
> outside of public view and risk being mothballed.

The submitter can go public anyway.  Most coordinators do not require
signing NDAs for submitters (some require them from software authors,
though).

A designated security contact would give submitters a choice: either
go public directly, or try something else first.  And believe, some
vulnerabilities really need a tested fix which is published at the
time of disclosure (death by single packet, for example). 
