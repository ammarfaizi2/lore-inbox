Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268851AbUJTVU7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268851AbUJTVU7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 17:20:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267951AbUJTVU4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 17:20:56 -0400
Received: from fw.osdl.org ([65.172.181.6]:39373 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S269100AbUJTVUf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 17:20:35 -0400
Date: Wed, 20 Oct 2004 14:24:20 -0700
From: Andrew Morton <akpm@osdl.org>
To: Matthias Andree <matthias.andree@gmx.de>
Cc: linux-kernel@vger.kernel.org, linux-net@vger.kernel.org
Subject: Re: 2.6.9 network regression killing amanda - 3c59x?
Message-Id: <20041020142420.0d513191.akpm@osdl.org>
In-Reply-To: <20041020191203.GA14356@merlin.emma.line.org>
References: <20041020191203.GA14356@merlin.emma.line.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Matthias Andree <matthias.andree@gmx.de> wrote:
>
> Has the 3c59x driver changed between 2.6.8.1 and 2.6.9?

Not much, really.  Just vlan support.

> Which patches or changesets are worth backing out?

Try the 2.6.8.1 driver in a 2.6.9 kernel?
