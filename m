Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932102AbVHWPFQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVHWPFQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 11:05:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932173AbVHWPFQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 11:05:16 -0400
Received: from mx1.redhat.com ([66.187.233.31]:16081 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S932102AbVHWPFP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 11:05:15 -0400
Date: Tue, 23 Aug 2005 11:05:01 -0400
From: Dave Jones <davej@redhat.com>
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] suspend: update warnings
Message-ID: <20050823150501.GA23171@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Nigel Cunningham <ncunningham@cyclades.com>,
	Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@zip.com.au>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20050822081528.GA4418@elf.ucw.cz> <1124753566.5093.8.camel@localhost> <20050823125017.GB3664@elf.ucw.cz> <1124801595.4602.18.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1124801595.4602.18.camel@localhost>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2005 at 10:53:16PM +1000, Nigel Cunningham wrote:

 > > > - CPU Freq  (improving too)
 > > > It might be good to mention these areas too.
 > > Well, right; but those 'only' cause system to crash during suspend. I
 > > was talking about really dangerous stuff.
 > > Both usb and cpufreq seems to work okay here.
 > It depends on what you're using. I believe one of the usb root hub
 > drivers is okay, the others aren't. Similar for cpufreq.

If you know a specific cpufreq driver which has problems, I'm all ears.

		Dave

