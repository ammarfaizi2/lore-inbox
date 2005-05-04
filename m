Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261802AbVEDNWS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261802AbVEDNWS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 09:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261808AbVEDNWR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 09:22:17 -0400
Received: from mx1.suse.de ([195.135.220.2]:18329 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261802AbVEDNWP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 09:22:15 -0400
Date: Wed, 4 May 2005 15:22:15 +0200
From: Andi Kleen <ak@suse.de>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: avoid infinite loop in x86_64 interrupt return
Message-ID: <20050504132215.GF1174@wotan.suse.de>
References: <20050504050132.GA3899@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504050132.GA3899@opteron.random>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


It is already fixed in mainline. Actually I think it was a merging 
problem I had actually fixed it before the last merge in my tree, but 
some patches got lost :/

-Andi
