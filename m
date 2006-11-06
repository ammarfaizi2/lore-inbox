Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1753092AbWKFNdF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753092AbWKFNdF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Nov 2006 08:33:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753097AbWKFNdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Nov 2006 08:33:05 -0500
Received: from amsfep17-int.chello.nl ([213.46.243.15]:52623 "EHLO
	amsfep16-int.chello.nl") by vger.kernel.org with ESMTP
	id S1753092AbWKFNdD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Nov 2006 08:33:03 -0500
Subject: Re: [x86_64] soft lockup with sunrpc/nfsd (also DWARF2 unwinder
	stuck)
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: "Robin H. Johnson" <robbat2@gentoo.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061106044752.GP15897@curie-int.orbis-terrarum.net>
References: <20061106044752.GP15897@curie-int.orbis-terrarum.net>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 14:31:38 +0100
Message-Id: <1162819898.14238.1.camel@twins>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-11-05 at 20:47 -0800, Robin H. Johnson wrote:
> The -git head as of today (2.6.19-rc4-git9) has a bug with SunRPC by the looks
> of it. 

Does:
  http://lkml.org/lkml/2006/10/29/43

fix it?

