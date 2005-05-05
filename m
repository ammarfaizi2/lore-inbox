Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262068AbVEEL57@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262068AbVEEL57 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 May 2005 07:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262065AbVEEL57
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 May 2005 07:57:59 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:62108 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262059AbVEEL55
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 May 2005 07:57:57 -0400
Date: Thu, 5 May 2005 13:55:02 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, jgarzik@pobox.com
Subject: Re: 2.6.12-rc3-mm3
Message-ID: <20050505115502.GA4414@electric-eye.fr.zoreil.com>
References: <20050504221057.1e02a402.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050504221057.1e02a402.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> :
[...]
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.12-rc3/2.6.12-rc3-mm3/

r8169-new-pci-id.patch was announced in 2.6.12-rc3-mm1. It disappeared in
2.6.12-rc3-mm{2/3} without notification.

The change included in this patch is currently not in 2.6.12-rc3-mm3 as a
whole, nor in -linus as of b2d84f078a8be40f5ae3b4d2ac001e2a7f45fe4f

Is there a reason for the removal ?

On a related note, is it suggested to wait for a renewed -netdev tree or
to feed the pending r8169 stuff to -mm ?

--
Ueimor
