Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932849AbWKJLvN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932849AbWKJLvN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 06:51:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932848AbWKJLvN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 06:51:13 -0500
Received: from mx2.suse.de ([195.135.220.15]:44954 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932849AbWKJLvN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 06:51:13 -0500
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.19-rc5-mm1: HPC nx6325 breakage, VESA fb problem, md-raid problem
Date: Fri, 10 Nov 2006 12:51:08 +0100
User-Agent: KMail/1.9.5
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fbuihuu@gmail.com, adaplas@pol.net, NeilBrown <neilb@suse.de>
References: <20061108015452.a2bb40d2.akpm@osdl.org> <200611100719.07969.ak@suse.de> <200611101221.19581.rjw@sisk.pl>
In-Reply-To: <200611101221.19581.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611101251.08697.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> 
> Still I can post a dmesg log from a non-failing kernel, the output of lspci
> etc. if that helps.

No need, I can reproduce it on another test system now.

Will fix.

-Andi
