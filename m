Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262535AbVA0Jjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262535AbVA0Jjh (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 04:39:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262536AbVA0Jjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 04:39:37 -0500
Received: from one.firstfloor.org ([213.235.205.2]:57311 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S262535AbVA0Jjg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 04:39:36 -0500
To: Dan Malek <dan@embeddedalley.com>
Cc: Linux Kernel Development <linux-kernel@vger.kernel.org>,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH] add AMD NS 5535 support
References: <DB539902-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com>
From: Andi Kleen <ak@muc.de>
Date: Thu, 27 Jan 2005 10:39:34 +0100
In-Reply-To: <DB539902-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com> (Dan
 Malek's message of "Wed, 26 Jan 2005 22:58:32 -0800")
Message-ID: <m1r7k743e1.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dan Malek <dan@embeddedalley.com> writes:

> Hi Marcelo.
>
> This patch for 2.4 adds support for the AMD / National
> Semiconductor CS5535 chip set.  Provided by AMD
> as part of the Geode support.
>
> Signed-off-by:  Dan Malek <dan@embeddedalley.com>

How about you first submit all these patches for 2.6? 

It doesn't make much sense to add new features to 2.4 that are not
in 2.6, especially not at the current state of 2.4 (deep code freeze) 

-Andi
