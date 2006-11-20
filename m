Return-Path: <linux-kernel-owner+willy=40w.ods.org-S934092AbWKTMBe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934092AbWKTMBe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 07:01:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934095AbWKTMBe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 07:01:34 -0500
Received: from poczta.o2.pl ([193.17.41.142]:9927 "EHLO poczta.o2.pl")
	by vger.kernel.org with ESMTP id S934092AbWKTMBd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 07:01:33 -0500
Date: Mon, 20 Nov 2006 13:07:52 +0100
From: Jarek Poplawski <jarkao2@o2.pl>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AF_UNIX recv/shutdown race
Message-ID: <20061120120752.GE1001@ff.dom.local>
Mail-Followup-To: Jarek Poplawski <jarkao2@o2.pl>,
	linux-kernel@vger.kernel.org
References: <51488.68.160.147.35.1163979646.squirrel@webmail.metacarta.com> <20061120120159.GC1001@ff.dom.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061120120159.GC1001@ff.dom.local>
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2006 at 01:01:59PM +0100, Jarek Poplawski wrote:
> On 20-11-2006 00:40, jmalicki@metacarta.com wrote:
...
> Are you sure you can use spin_lock here? 

Sorry linux-kernel - it was for netdev.

Jarek P.
