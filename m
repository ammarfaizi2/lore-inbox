Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750873AbWEKSfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750873AbWEKSfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 May 2006 14:35:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750875AbWEKSfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 May 2006 14:35:55 -0400
Received: from cantor2.suse.de ([195.135.220.15]:39822 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750855AbWEKSfy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 May 2006 14:35:54 -0400
To: Zoltan Boszormenyi <zboszor@dunaweb.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in au8830 driver on x86-64
References: <446271C6.9050509@dunaweb.hu>
From: Andi Kleen <ak@suse.de>
Date: 11 May 2006 20:35:52 +0200
In-Reply-To: <446271C6.9050509@dunaweb.hu>
Message-ID: <p73d5ek76k7.fsf@bragg.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zoltan Boszormenyi <zboszor@dunaweb.hu> writes:
> 
> I couldn't seek further, I put the card away for now. :-)

First thing I would do is to fix all the compile warnings.

-Andi
