Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935399AbWKZOPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935399AbWKZOPu (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 09:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935401AbWKZOPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 09:15:50 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:63976 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S935399AbWKZOPt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 09:15:49 -0500
Date: Sun, 26 Nov 2006 14:22:13 +0000
From: Alan <alan@lxorguk.ukuu.org.uk>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Casey Dahlin <cjdahlin@ncsu.edu>, linux-kernel@vger.kernel.org
Subject: Re: Overriding X on panic
Message-ID: <20061126142213.52c292d3@localhost.localdomain>
In-Reply-To: <1164529121.3147.65.camel@laptopd505.fenrus.org>
References: <1164434093.10503.2.camel@localhost.localdomain>
	<1164443561.3147.54.camel@laptopd505.fenrus.org>
	<20061125161043.18f1b68d@localhost.localdomain>
	<1164529121.3147.65.camel@laptopd505.fenrus.org>
X-Mailer: Sylpheed-Claws 2.6.0 (GTK+ 2.8.20; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 26 Nov 2006 09:18:41 +0100
Arjan van de Ven <arjan@infradead.org> wrote:
> > The mode switch sequences for modern cards are a bit more hairy than
> > lists of I/O poking unfortunately. 
> 
> for the Intel hw Keith doesn't seem to think it's all that much of a
> problem though...

Including the TV out, odder LCD panels, non BIOS modes etc ? If so then
it might be an interesting test case for intelfb to grow some kind of
console helper interface

Alan
