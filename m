Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758042AbWK0LO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758042AbWK0LO1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 06:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758041AbWK0LO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 06:14:27 -0500
Received: from mail.suse.de ([195.135.220.2]:63924 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S1758039AbWK0LO0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 06:14:26 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC: 2.6 patch] i386: always enable regparm
References: <20061126043125.GI15364@stusta.de>
From: Andi Kleen <ak@suse.de>
Date: 27 Nov 2006 12:14:25 +0100
In-Reply-To: <20061126043125.GI15364@stusta.de>
Message-ID: <p73irh1dtv2.fsf@bingen.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk <bunk@stusta.de> writes:

> -mregparm=3 has been enabled by default for some time on i386, and AFAIK 
> there aren't any problems with it left.
> 
> This patch removes the REGPARM config option and sets -mregparm=3 
> unconditionally.

Added thanks
-Andi
