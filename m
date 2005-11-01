Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751114AbVKATJJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVKATJJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 14:09:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751130AbVKATJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 14:09:09 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:17343 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751114AbVKATJH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 14:09:07 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] preempt-trace.patch
Date: Tue, 1 Nov 2005 20:08:51 +0100
User-Agent: KMail/1.8.2
Cc: Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@osdl.org>,
       Ashok Raj <ashok.raj@intel.com>, Dave Jones <davej@codemonkey.org.uk>
References: <200510311606.36615.rjw@sisk.pl> <20051031113413.34a599cd.akpm@osdl.org> <20051031214202.GA17489@elte.hu>
In-Reply-To: <20051031214202.GA17489@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200511012008.52404.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Monday, 31 of October 2005 22:42, Ingo Molnar wrote:
> 
> * Andrew Morton <akpm@osdl.org> wrote:
> 
> > Well I can't find it.  Ingo, didn't you have a debug patch which would 
> > help us identify where this atomic section started?
> 
> yes. Find below the preempt-trace.patch, updated and merged to 2.6.14.
> 
> Rafael, just enable CONFIG_DEBUG_PREEMPT and repeat the reproducer.

Thanks a lot, but it was not necessary in this particular case (please see
my reply to the Ashok's post).

Greetings,
Rafael
