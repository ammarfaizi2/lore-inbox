Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755340AbWKMVwn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755340AbWKMVwn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 16:52:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755356AbWKMVwm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 16:52:42 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:42196 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP
	id S1755355AbWKMVwl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 16:52:41 -0500
Message-ID: <4558E928.5050907@vmware.com>
Date: Mon, 13 Nov 2006 13:52:40 -0800
From: Zachary Amsden <zach@vmware.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061025)
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       mingo@redhat.com
Subject: Re: [-mm patch] make arch/i386/kernel/io_apic.c:timer_irq_works()
 static again
References: <20061108015452.a2bb40d2.akpm@osdl.org> <20061113210349.GF22565@stusta.de>
In-Reply-To: <20061113210349.GF22565@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> timer_irq_works() needlessly became global.
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>   

Ack'd-by: Zachary Amsden <zach@vmware.com>
