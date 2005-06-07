Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262033AbVFGXPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbVFGXPx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Jun 2005 19:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262032AbVFGXPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Jun 2005 19:15:53 -0400
Received: from electric-eye.fr.zoreil.com ([213.41.134.224]:6103 "EHLO
	fr.zoreil.com") by vger.kernel.org with ESMTP id S262033AbVFGXPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Jun 2005 19:15:49 -0400
Date: Wed, 8 Jun 2005 01:15:02 +0200
From: Francois Romieu <romieu@fr.zoreil.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.12-rc6-mm1
Message-ID: <20050607231502.GC30023@electric-eye.fr.zoreil.com>
References: <20050607042931.23f8f8e0.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050607042931.23f8f8e0.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
X-Organisation: Land of Sunshine Inc.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> :
[...]
> -git-netdev-r8169.patch
> 
>  Too many rejects from this one.

How did you generate git-netdev-r8169.patch ?

Jeff's 'upstream-2.6.13' includes all the pending r8169 changes and
nothing will be merged before 2.6.12 is out. Imho you can safely
ignore any r8169 change until 2.6.12 appears.

--
Ueimor
