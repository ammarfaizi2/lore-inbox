Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262759AbTIQNvK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Sep 2003 09:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262762AbTIQNvK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Sep 2003 09:51:10 -0400
Received: from zork.zork.net ([64.81.246.102]:42624 "EHLO zork.zork.net")
	by vger.kernel.org with ESMTP id S262759AbTIQNvJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Sep 2003 09:51:09 -0400
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test5-mm2
References: <20030914234843.20cea5b3.akpm@osdl.org>
From: Sean Neakums <sneakums@zork.net>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
 linux-kernel@vger.kernel.org,  linux-mm@kvack.org
Date: Wed, 17 Sep 2003 14:51:05 +0100
In-Reply-To: <20030914234843.20cea5b3.akpm@osdl.org> (Andrew Morton's
 message of "Sun, 14 Sep 2003 23:48:43 -0700")
Message-ID: <6usmmvr0ae.fsf@zork.zork.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've forgotten precisely when it stopped working (test4 or test4-mm1,
maybe), but I chanced to try it today and I've been able to
successfully do APM suspend to/resume from RAM with this kernel.

