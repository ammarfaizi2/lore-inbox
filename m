Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932388AbVKUR1v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932388AbVKUR1v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Nov 2005 12:27:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbVKUR1u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Nov 2005 12:27:50 -0500
Received: from cantor.suse.de ([195.135.220.2]:14307 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932391AbVKUR1t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Nov 2005 12:27:49 -0500
Date: Mon, 21 Nov 2005 18:27:42 +0100
From: Andi Kleen <ak@suse.de>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: Andi Kleen <ak@suse.de>, virtualization@lists.osdl.org, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: (no subject)
Message-ID: <20051121172742.GC20775@brahms.suse.de>
References: <437DFBB3.mailLJC11TKEB@suse.de> <31100cb5abcb16617981e6923dd165d0@cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <31100cb5abcb16617981e6923dd165d0@cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> We could make use of virt_to_machine/machine_to_virt instead, which 

I don't like it because "machine" is quite meaningless outside
Xen. 

-Andi
