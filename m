Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264629AbSKMVJh>; Wed, 13 Nov 2002 16:09:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264610AbSKMVIg>; Wed, 13 Nov 2002 16:08:36 -0500
Received: from ns.suse.de ([213.95.15.193]:63238 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S263968AbSKMVHq>;
	Wed, 13 Nov 2002 16:07:46 -0500
To: Arjan van de Ven <arjanv@redhat.com>
Cc: linux-kernel@vger.kernel.org, rusty@linux.co.intel.com
Subject: Re: [PATCH][2.5.47]Add exported valid_kernel_address()
References: <200211132013.gADKDhS01389@linux.intel.com.suse.lists.linux.kernel> <1037220406.2889.4.camel@localhost.localdomain.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 13 Nov 2002 22:14:38 +0100
In-Reply-To: Arjan van de Ven's message of "13 Nov 2002 22:09:38 +0100"
Message-ID: <p7365v1w4sh.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjanv@redhat.com> writes:

> it is customary that people who ask for an export explain why they need
> it.... would you mind explaining that ?

For modular lkcd I guess. Make a lot of sense to do it modular.

-Andi
