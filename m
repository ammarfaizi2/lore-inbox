Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264262AbUEXMBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264262AbUEXMBp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 May 2004 08:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264263AbUEXMBp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 May 2004 08:01:45 -0400
Received: from canuck.infradead.org ([205.233.217.7]:37383 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S264262AbUEXMBj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 May 2004 08:01:39 -0400
Date: Mon, 24 May 2004 08:01:38 -0400
From: hch@infradead.org
To: "Peter J. Braam" <braam@clusterfs.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
       "'Phil Schwan'" <phil@clusterfs.com>
Subject: Re: [PATCH/RFC] Lustre VFS patch
Message-ID: <20040524120138.GB26863@infradead.org>
Mail-Followup-To: hch@infradead.org, "Peter J. Braam" <braam@clusterfs.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org,
	'Phil Schwan' <phil@clusterfs.com>
References: <20040524114009.96CE13100E2@moraine.clusterfs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040524114009.96CE13100E2@moraine.clusterfs.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 24, 2004 at 07:39:50PM +0800, Peter J. Braam wrote:
> lustre_version.patch
>  
>   A tiny header to check that the kernel patch and Lustre modules are
>   compatible.

	bogus.  check KERNEL_VERSION if you want this merged.

