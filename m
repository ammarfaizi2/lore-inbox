Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262275AbVC3Pxr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262275AbVC3Pxr (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Mar 2005 10:53:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262296AbVC3Pxr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Mar 2005 10:53:47 -0500
Received: from mx1.suse.de ([195.135.220.2]:42910 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262287AbVC3Pxm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Mar 2005 10:53:42 -0500
Date: Wed, 30 Mar 2005 17:53:39 +0200
From: Andi Kleen <ak@suse.de>
To: Ian Campbell <icampbell@arcom.com>
Cc: Andrew Morton <akpm@osdl.org>, rmk@arm.linux.org.uk, spyro@f2s.com,
       paulus@samba.org, schwidefsky@de.ibm.com, ak@suse.de,
       linux-kernel@vger.kernel.org
Subject: Re: use ${CROSS_COMPILE}installkernel in arch/*/boot/install.sh
Message-ID: <20050330155339.GJ28472@wotan.suse.de>
References: <1112197767.18208.34.camel@icampbell-debian>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1112197767.18208.34.camel@icampbell-debian>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I only use ARM and i386 myself but I figured it couldn't hurt to do the
> whole lot. I've cc'd those who I hope are the arch maintainers for files
> that I've touched.

Fine for x86-64.

-Andi
