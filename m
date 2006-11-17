Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1756000AbWKQWpb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756000AbWKQWpb (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 17:45:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756003AbWKQWpb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 17:45:31 -0500
Received: from gw.goop.org ([64.81.55.164]:49028 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1756000AbWKQWpa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 17:45:30 -0500
Message-ID: <455E3E6A.9090600@goop.org>
Date: Fri, 17 Nov 2006 14:57:46 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: eranian@hpl.hp.com, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] i386 add Intel PEBS and BTS cpufeature bits and detection
References: <20061115213241.GC17238@frankl.hpl.hp.com> <455D11B9.4080302@goop.org> <200611170529.02460.ak@suse.de>
In-Reply-To: <200611170529.02460.ak@suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I have had private patches for that myself, using the MSRs on AMD
> and Intel.
>   

Would they be something that could be cleaned up into something
mergeable?  It would be nice to have something that could be left
enabled all the time, but an option would at least make the
functionality available.

    J
