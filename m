Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265410AbUFTL0e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265410AbUFTL0e (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jun 2004 07:26:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265782AbUFTL0e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jun 2004 07:26:34 -0400
Received: from cantor.suse.de ([195.135.220.2]:33180 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S265410AbUFTL0c (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jun 2004 07:26:32 -0400
Date: Sun, 20 Jun 2004 15:22:56 +0200
From: Andi Kleen <ak@suse.de>
To: "R. J. Wysocki" <rjwysocki@sisk.pl>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org
Subject: Re: Opteron bug
Message-Id: <20040620152256.4a173a95.ak@suse.de>
In-Reply-To: <200406192229.14296.rjwysocki@sisk.pl>
References: <200406192229.14296.rjwysocki@sisk.pl>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004 22:29:14 +0200
"R. J. Wysocki" <rjwysocki@sisk.pl> wrote:

> Hi,
> 
> I hope everyone interested in the development for Opteron is aware of the bug 
> described here:
> 
> http://www.3dchips.net/content/story.php?id=3927

The kernel never uses backwards REP prefixes.

-Andi
