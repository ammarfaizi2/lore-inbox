Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933275AbWKSUzS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933275AbWKSUzS (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Nov 2006 15:55:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933278AbWKSUzS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Nov 2006 15:55:18 -0500
Received: from mx1.redhat.com ([66.187.233.31]:20687 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S933275AbWKSUzQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Nov 2006 15:55:16 -0500
Date: Sun, 19 Nov 2006 15:55:03 -0500
From: Dave Jones <davej@redhat.com>
To: David Rientjes <rientjes@cs.washington.edu>
Cc: Dave Jones <davej@codemonkey.org.uk>, Hiroshi Miura <miura@da-cha.org>,
       Zwane Mwaikambo <zwane@commfireservices.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 cpufreq: cs5530A allows active idle
Message-ID: <20061119205503.GB1832@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	David Rientjes <rientjes@cs.washington.edu>,
	Dave Jones <davej@codemonkey.org.uk>,
	Hiroshi Miura <miura@da-cha.org>,
	Zwane Mwaikambo <zwane@commfireservices.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.64N.0611191121050.391@attu4.cs.washington.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0611191121050.391@attu4.cs.washington.edu>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 19, 2006 at 11:24:08AM -0800, David Rientjes wrote:
 > The cs5530A will be able to go into active idle (PWRSVE) so its PCI class 
 > revision should be accurately stored.

Already queued in cpufreq.git for .20

		Dave

-- 
http://www.codemonkey.org.uk
