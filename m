Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbVHNDDH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbVHNDDH (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 13 Aug 2005 23:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932426AbVHNDDH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Aug 2005 23:03:07 -0400
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:51665 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S932419AbVHNDDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Aug 2005 23:03:06 -0400
X-ORBL: [63.205.185.3]
Date: Sat, 13 Aug 2005 20:02:56 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Olaf Hering <olh@suse.de>
Cc: Christoph Hellwig <hch@infradead.org>,
       Henrik Brix Andersen <brix@gentoo.org>, linux-kernel@vger.kernel.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Watchdog device node name unification
Message-ID: <20050814030256.GA21147@taniwha.stupidest.org>
References: <1123969015.13656.13.camel@sponge.fungus> <20050813232519.GA20256@infradead.org> <20050813234322.GA30563@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050813234322.GA30563@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 14, 2005 at 01:43:22AM +0200, Olaf Hering wrote:

> It is used for /class/misc/$name/dev

Ick.  I would almost suggest we change that were it not too late.  I
think keeping the decription is useful and desirable.
