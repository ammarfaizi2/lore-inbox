Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932087AbWJMVfo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932087AbWJMVfo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 17:35:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932088AbWJMVfo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 17:35:44 -0400
Received: from ozlabs.org ([203.10.76.45]:3003 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S932087AbWJMVfn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 17:35:43 -0400
Date: Sat, 14 Oct 2006 07:34:23 +1000
From: Anton Blanchard <anton@samba.org>
To: Nathan Lynch <ntl@pobox.com>
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>, linuxppc-dev@ozlabs.org,
       linux-kernel@vger.kernel.org, Christoph Lameter <clameter@sgi.com>
Subject: Re: kernel BUG in __cache_alloc_node at linux-2.6.git/mm/slab.c:3177!
Message-ID: <20061013213423.GG16029@krispykreme>
References: <1160764895.11239.14.camel@farscape> <Pine.LNX.4.64.0610131158270.26311@schroedinger.engr.sgi.com> <1160769226.11239.22.camel@farscape> <1160773040.11239.28.camel@farscape> <20061013212202.GG28620@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061013212202.GG28620@localdomain>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> Strange, node 0 appears to be in the middle of node 1.

Its an odd setup and may be a firmware issue but Ive seen it a number of
times on POWER5 boxes.

Anton
