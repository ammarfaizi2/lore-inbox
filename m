Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272541AbTHKHN2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 03:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272542AbTHKHN2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 03:13:28 -0400
Received: from sinma-gmbh.17.mind.de ([212.21.92.17]:39182 "EHLO gw.enyo.de")
	by vger.kernel.org with ESMTP id S272541AbTHKHN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 03:13:28 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: [2.6.0-test3] Hyperthreading gone
References: <87llu2bvxg.fsf@deneb.enyo.de>
	<20030809221706.GA2106@glitch.localdomain>
	<87oeyyc7u9.fsf@deneb.enyo.de>
	<20030810120032.GA14437@glitch.localdomain>
From: Florian Weimer <fw@deneb.enyo.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Date: Mon, 11 Aug 2003 09:13:24 +0200
In-Reply-To: <20030810120032.GA14437@glitch.localdomain> (Greg Norris's
 message of "Sun, 10 Aug 2003 07:00:32 -0500")
Message-ID: <87bruw1xbf.fsf@deneb.enyo.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg Norris <haphazard@kc.rr.com> writes:

> According to the 2.6.0-test3 menuconfig help text, the parameter is
> required when CPU Enumeration Only is selected, and enables only
> limited ACPI support.

I don't think it's clear from the description.  It's certainly
unexpected that a compile-time option doesn't activate a feature, but
merely adds a boot option to do so.

Anyway, I can't test right now because 2.6 is still eating the file
system. 8-(
