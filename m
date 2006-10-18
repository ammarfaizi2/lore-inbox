Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751534AbWJRXM4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751534AbWJRXM4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 19:12:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751537AbWJRXM4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 19:12:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4837 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751534AbWJRXMz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 19:12:55 -0400
Date: Wed, 18 Oct 2006 16:12:32 -0700
From: Andrew Morton <akpm@osdl.org>
To: Jiri Kosina <jikos@jikos.cz>
Cc: Gabriel C <nix.or.die@googlemail.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc2-mm1
Message-Id: <20061018161232.876c13b0.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610190103190.29022@twin.jikos.cz>
References: <20061016230645.fed53c5b.akpm@osdl.org>
	<453675A6.9080001@googlemail.com>
	<Pine.LNX.4.64.0610182330340.29022@twin.jikos.cz>
	<20061018152947.bb404481.akpm@osdl.org>
	<Pine.LNX.4.64.0610190031260.29022@twin.jikos.cz>
	<20061018154636.2317059a.akpm@osdl.org>
	<Pine.LNX.4.64.0610190055440.29022@twin.jikos.cz>
	<Pine.LNX.4.64.0610190103190.29022@twin.jikos.cz>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Oct 2006 01:04:42 +0200 (CEST)
Jiri Kosina <jikos@jikos.cz> wrote:

> This if of course bogus, the one below should be better, sorry
> 
> [PATCH] Fix spurious warning in i_size_write

OK, thanks - let's give that a try, see how it goes.
