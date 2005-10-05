Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965097AbVJEVIX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965097AbVJEVIX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 17:08:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965095AbVJEVIX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 17:08:23 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:46771 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S965010AbVJEVIW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 17:08:22 -0400
Date: Wed, 5 Oct 2005 23:05:52 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Aurelien Jarno <aurelien@aurel32.net>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.14-rc3] sis190.c: fix multicast MAC filter
Message-ID: <20051005210552.GA18923@electric-eye.fr.zoreil.com>
References: <20051005203350.GA3096@farad.aurel32.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051005203350.GA3096@farad.aurel32.net>
User-Agent: Mutt/1.4.2.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Aurelien Jarno <aurelien@aurel32.net> :
> Here is a patch that changes the way the MAC filter is computed for the
> multicast addresses. The computation is taken from the SiS GPL driver. 

Ok.

[...]
> This patch is necessary to get IPv6 working.

May I assume that it has been tested on the usual k8s-mx ?

If so, feel free to forward to jgarzik@pobox.com and netdev@vger.kernel.org.
I've just bought a mobo to test this adapter but it will not be ready before
this week end.

--
Ueimor
