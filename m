Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266903AbSKOWjD>; Fri, 15 Nov 2002 17:39:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266888AbSKOWjC>; Fri, 15 Nov 2002 17:39:02 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:57605 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S266886AbSKOWjB>;
	Fri, 15 Nov 2002 17:39:01 -0500
Message-ID: <3DD57906.3060404@pobox.com>
Date: Fri, 15 Nov 2002 17:45:26 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2b) Gecko/20021018
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
CC: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PARAM 1/4: strcspn
References: <20021115222725.1A56F2C0FA@lists.samba.org>
In-Reply-To: <20021115222725.1A56F2C0FA@lists.samba.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Should we assume from $subject that namespace abuse is still occurring?

PARAM is way too generic, and while you may not like MODULE_PARAM or 
KPARAM or similar, I should hope it's self-evident that "param" i.e. 
"parameters" can apply to a great many things inside the kernel.

"PARAM" definitely does not suggest to the casual reader "kernel boot 
command line arguments, or, module arguments"

	Jeff



