Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262340AbVBBU2v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262340AbVBBU2v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 15:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262474AbVBBUZN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 15:25:13 -0500
Received: from fw.osdl.org ([65.172.181.6]:62932 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262545AbVBBUTh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 15:19:37 -0500
Date: Wed, 2 Feb 2005 12:19:22 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
Cc: clameter@sgi.com, mel@csn.ul.ie, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH 2/2] Helping prezoring with reduced fragmentation
 allocation
Message-Id: <20050202121922.1251c677.akpm@osdl.org>
In-Reply-To: <20050202164936.GA23718@logos.cnet>
References: <20050201171641.CC15EE5E8@skynet.csn.ul.ie>
	<Pine.LNX.4.58.0502011110560.3436@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0502011929020.16992@skynet>
	<Pine.LNX.4.58.0502011604130.5406@schroedinger.engr.sgi.com>
	<Pine.LNX.4.58.0502020026040.16992@skynet>
	<20050202164936.GA23718@logos.cnet>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo.tosatti@cyclades.com> wrote:
>
>  What are your thoughts about inclusion of Mel's allocator work on -mm ?

It's sitting in my to-do pile.
