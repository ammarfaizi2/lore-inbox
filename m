Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261265AbVAaRJE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbVAaRJE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jan 2005 12:09:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261271AbVAaRHL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jan 2005 12:07:11 -0500
Received: from [81.2.110.250] ([81.2.110.250]:10459 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S261265AbVAaRGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jan 2005 12:06:49 -0500
Subject: Re: [PATCH] add AMD NS 5535 support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Dan Malek <dan@embeddedalley.com>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
In-Reply-To: <DB539902-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com>
References: <DB539902-7030-11D9-A0FB-003065F9B7DC@embeddedalley.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107172161.14787.79.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 31 Jan 2005 16:01:42 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-27 at 06:58, Dan Malek wrote:
> Hi Marcelo.
> 
> This patch for 2.4 adds support for the AMD / National
> Semiconductor CS5535 chip set.  Provided by AMD
> as part of the Geode support.
> 
> Signed-off-by:  Dan Malek <dan@embeddedalley.com>

This belongs in 2.6 not 2.4 but it does look fairly passable as a
starting point for 2.6 - you might want to bounce it to linux-ide@..
instead of linux-kernel

Comment syntax wants to be kernel-doc for a merge tho

Alan
