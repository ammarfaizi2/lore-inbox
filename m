Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWHaKZX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWHaKZX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Aug 2006 06:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751087AbWHaKZX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Aug 2006 06:25:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:10381 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751070AbWHaKZW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Aug 2006 06:25:22 -0400
From: Andi Kleen <ak@suse.de>
To: Akinobu Mita <mita@miraclelinux.com>
Subject: Re: [patch 1/6] fault-injection capabilities infrastructure
Date: Thu, 31 Aug 2006 12:22:25 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, okuji@enbug.org
References: <20060831100756.866727476@localhost.localdomain> <20060831100819.676694231@localhost.localdomain>
In-Reply-To: <20060831100819.676694231@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608311222.25187.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 31 August 2006 12:07, Akinobu Mita wrote:
>
> Index: work-shouldfail/lib/should_fail.c
> ===================================================================
> --- /dev/null
> +++ work-shouldfail/lib/should_fail.c
> @@ -0,0 +1,82 @@

You really need some more comments in this file, describing
what it does in a high level way. Or ideally something
in Documentation/* describing what the various modules
do and how to use them? 


-Andi
