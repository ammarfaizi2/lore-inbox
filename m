Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261909AbTHTMEB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 08:04:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbTHTMEB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 08:04:01 -0400
Received: from ns.suse.de ([195.135.220.2]:6798 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261909AbTHTMEA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 08:04:00 -0400
Date: Wed, 20 Aug 2003 14:03:59 +0200
From: Andi Kleen <ak@suse.de>
To: Hannes Reinecke <Hannes.Reinecke@suse.de>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Dumb question: BKL on reboot ?
Message-ID: <20030820120359.GA29915@wotan.suse.de>
References: <3F434BD1.9050704@suse.de.suse.lists.linux.kernel> <p73wud861tg.fsf@oldwotan.suse.de> <3F4360D3.8070004@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3F4360D3.8070004@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Is it worth to try to push it into mainstream kernel?

Yes definitely. My patch was for 2.6.0test3. 

-Andi
