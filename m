Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751168AbWIKHmP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751168AbWIKHmP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 03:42:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751170AbWIKHmP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 03:42:15 -0400
Received: from gw.goop.org ([64.81.55.164]:13791 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751168AbWIKHmN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 03:42:13 -0400
Message-ID: <4505134F.3050204@goop.org>
Date: Mon, 11 Sep 2006 00:42:07 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060907)
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Laurent Riffard <laurent.riffard@free.fr>,
       Arjan van de Ven <arjan@infradead.org>,
       Kernel development list <linux-kernel@vger.kernel.org>,
       Jeremy Fitzhardinge <jeremy@xensource.com>
Subject: Re: [patch] i386-PDA, lockdep: fix %gs restore
References: <20060908011317.6cb0495a.akpm@osdl.org> <200609101032.17429.ak@suse.de> <20060910115722.GA15356@elte.hu> <200609101334.34867.ak@suse.de> <20060910132614.GA29423@elte.hu> <20060910093307.a011b16f.akpm@osdl.org> <450499D3.5010903@goop.org> <20060911052527.GA12301@elte.hu>
In-Reply-To: <20060911052527.GA12301@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> could you back out Andi's patch and try the patch below, does it fix the 
> crash too?
>   
Looks sensible.

    J
