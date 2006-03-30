Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWC3KfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWC3KfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Mar 2006 05:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932166AbWC3KfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Mar 2006 05:35:06 -0500
Received: from mx1.suse.de ([195.135.220.2]:46034 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932165AbWC3KfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Mar 2006 05:35:05 -0500
From: Andi Kleen <ak@suse.de>
To: Voluspa <lista1@telia.com>
Subject: Re: [2.6.16-gitX] (x86_64) WARNING: vmlinux: 'strlen' exported twice. Previous export was in vmlinux
Date: Thu, 30 Mar 2006 12:31:14 +0200
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org
References: <20060330035318.41a5b74c.lista1@telia.com> <200603300405.59138.ak@suse.de> <20060330041754.0c527686.lista1@telia.com>
In-Reply-To: <20060330041754.0c527686.lista1@telia.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603301231.14375.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 30 March 2006 04:17, Voluspa wrote:

> loke@sleipner:/home/git$ gcc --version
> gcc (GCC) 3.4.4
> 
> This is a slamd64 current distribution. Attaching .config

Ok thanks fixed now.

-Andi

