Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751242AbWIMWxd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751242AbWIMWxd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 18:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751243AbWIMWxd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 18:53:33 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:11178 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751242AbWIMWxc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 18:53:32 -0400
Date: Wed, 13 Sep 2006 15:53:27 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: Lee Schermerhorn <Lee.Schermerhorn@hp.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-mm <linux-mm@kvack.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.18-rc6-mm2] fix migrate_page_move_mapping for radix
 tree cleanup
In-Reply-To: <1158187707.5328.86.camel@localhost>
Message-ID: <Pine.LNX.4.64.0609131553130.20630@schroedinger.engr.sgi.com>
References: <1158187707.5328.86.camel@localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2006, Lee Schermerhorn wrote:

> Alternative to my "revert migrate_move_mapping ..." patch:

Acked-by: Christoph Lameter <clameter@sgi.com>
