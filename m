Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751089AbWGZRzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbWGZRzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751091AbWGZRzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:55:31 -0400
Received: from mx1.redhat.com ([66.187.233.31]:25250 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751089AbWGZRza (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:55:30 -0400
Date: Wed, 26 Jul 2006 13:53:06 -0400
From: Dave Jones <davej@redhat.com>
To: Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       Arjan van de Ven <arjan@linux.intel.com>,
       Ashok Raj <ashok.raj@intel.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: remove cpu hotplug bustification in cpufreq.
Message-ID: <20060726175306.GG28945@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Ashok Raj <ashok.raj@intel.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@osdl.org>
References: <200607242023_MC3-1-C5FE-CADB@compuserve.com> <Pine.LNX.4.64.0607241752290.29649@g5.osdl.org> <20060725185449.GA8074@elte.hu> <20060725204624.GF13829@redhat.com> <20060726171257.GC6868@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060726171257.GC6868@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2006 at 06:12:57PM +0100, Russell King wrote:

 > > Things used to be fairly simple until hotplug cpu came along :-/
 > > Each day, I'm getting more of the opinion that my patch just ripping
 > > out this garbage is the right solution.
 > 
 > Not sure if I'm reading your sentiment correctly, but...

You didn't.
The garbage I referred to was 'cpu hotplug locking'.

		Dave

-- 
http://www.codemonkey.org.uk
