Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266452AbUBFEAa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 23:00:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266454AbUBFEAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 23:00:30 -0500
Received: from fw.osdl.org ([65.172.181.6]:64221 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266452AbUBFEA1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 23:00:27 -0500
Date: Thu, 5 Feb 2004 20:02:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Dylan Griffiths <dylang+kernel@thock.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: HFSPLus driver for Linux 2.6.
Message-Id: <20040205200217.360c51ab.akpm@osdl.org>
In-Reply-To: <40231076.7040307@thock.com>
References: <402304F0.1070008@thock.com>
	<20040205191527.4c7a488e.akpm@osdl.org>
	<40231076.7040307@thock.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dylan Griffiths <dylang+kernel@thock.com> wrote:
>
> 	I don't remember where I grabbed this driver, I only know it's much 
>  more current than the one at 
>  http://sourceforge.net/projects/linux-hfsplus.

Sorry, that's a showstopper.  We need to understand who the maintenance
team is, and evaluate their preparedness to maintain this code long-term.

We don't want to be adding yet another rarely-used filesystem which has no
visible maintenance team.

