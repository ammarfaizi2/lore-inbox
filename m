Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161167AbWHJLKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161167AbWHJLKV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 07:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161168AbWHJLKV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 07:10:21 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:27545 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1161167AbWHJLKV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 07:10:21 -0400
Date: Thu, 10 Aug 2006 13:10:03 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Jeff Dike <jdike@addtoit.com>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net,
       Matt Mackall <mpm@selenic.com>
Subject: Re: [PATCH] UML - support checkstack
Message-ID: <20060810111003.GA11194@wohnheim.fh-wedel.de>
References: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200608091815.k79IFQVB005310@ccure.user-mode-linux.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 August 2006 14:15:24 -0400, Jeff Dike wrote:
> 
> Make checkstack work for UML.  We need to pass the underlying architecture
> name, rather than "um" to checkstack.pl.
> 
> Signed-off-by: Jeff Dike <jdike@addtoit.com>

Acked-by: Joern Engel <joern@wohnheim.fh-wedel.de>

Jörn

-- 
Geld macht nicht glücklich.
Glück macht nicht satt.
