Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750851AbWAUAE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750851AbWAUAE1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 19:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750824AbWAUAE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 19:04:27 -0500
Received: from gate.in-addr.de ([212.8.193.158]:57998 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1750822AbWAUAE0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 19:04:26 -0500
Date: Sat, 21 Jan 2006 01:03:44 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: Heinz Mauelshagen <mauelshagen@redhat.com>
Cc: Neil Brown <neilb@suse.de>, Phillip Susi <psusi@cfl.rr.com>,
       Jan Engelhardt <jengelh@linux01.gwdg.de>,
       "Lincoln Dale (ltd)" <ltd@cisco.com>, Michael Tokarev <mjt@tls.msk.ru>,
       linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
       "Steinar H. Gunderson" <sgunderson@bigfoot.com>
Subject: Re: [PATCH 000 of 5] md: Introduction
Message-ID: <20060121000344.GY22163@marowsky-bree.de>
References: <26A66BC731DAB741837AF6B2E29C1017D47EA0@xmb-hkg-413.apac.cisco.com> <Pine.LNX.4.61.0601181427090.19392@yvahk01.tjqt.qr> <17358.52476.290687.858954@cse.unsw.edu.au> <43D00FFA.1040401@cfl.rr.com> <17360.5011.975665.371008@cse.unsw.edu.au> <43D02033.4070008@cfl.rr.com> <17360.9233.215291.380922@cse.unsw.edu.au> <20060120183621.GA2799@redhat.com> <20060120225724.GW22163@marowsky-bree.de> <20060121000142.GR2801@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20060121000142.GR2801@redhat.com>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2006-01-21T01:01:42, Heinz Mauelshagen <mauelshagen@redhat.com> wrote:

> > Why not provide a dm-md wrapper which could then
> > load/interface to all md personalities?
> As we want to enrich the mapping flexibility (ie, multi-segment fine grained
> mappings) of dm by adding targets as we go, a certain degree and transitional
> existence of duplicate code is the price to gain that flexibility.

A dm-md wrapper would give you the same?


Sincerely,
    Lars Marowsky-Brée

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

