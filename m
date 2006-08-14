Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751418AbWHNONL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751418AbWHNONL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 10:13:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWHNONL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 10:13:11 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:51086 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751418AbWHNONJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 10:13:09 -0400
Date: Mon, 14 Aug 2006 07:13:02 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
cc: Andrew Morton <akpm@osdl.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [patch -mm] s390: remove HIGHMEM dependencies
In-Reply-To: <20060814070054.GB9592@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.64.0608140712340.2863@schroedinger.engr.sgi.com>
References: <20060813012454.f1d52189.akpm@osdl.org>
 <20060814070054.GB9592@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Aug 2006, Heiko Carstens wrote:

> s390 doesn't support CONFIG_HIGHMEM. Anything that depends on it would be
> dead code.

Acked-by: Christoph Lameter <clameter@sgi.com>
