Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266599AbUG0UMI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266599AbUG0UMI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 16:12:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266582AbUG0UKb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 16:10:31 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:25041 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S266580AbUG0UKY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 16:10:24 -0400
Date: Mon, 26 Jul 2004 23:22:55 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: lkml List <linux-kernel@vger.kernel.org>
Subject: Re: Preliminary Linux Key Infrastructure 0.01-alpha1
Message-ID: <20040726212255.GD21889@openzaurus.ucw.cz>
References: <65EFF013-DEAA-11D8-9612-000393ACC76E@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <65EFF013-DEAA-11D8-9612-000393ACC76E@mac.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> In Progress:
> 	lki_keyring_blob_t & methods
> 		A special-case of a key. 
See CodingStyle, naming structure *_blob_t is ugly.
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

