Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266741AbUF3QKV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266741AbUF3QKV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:10:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUF3QIu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:08:50 -0400
Received: from mx1.redhat.com ([66.187.233.31]:50066 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266741AbUF3QIJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:08:09 -0400
Date: Wed, 30 Jun 2004 12:07:42 -0400
From: Alan Cox <alan@redhat.com>
To: bm <b.melnicki@nova-trading.com>
Cc: Alan Cox <alan@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Further aacraid work
Message-ID: <20040630160742.GA21105@devserv.devel.redhat.com>
References: <20040616210455.GA13385@devserv.devel.redhat.com> <008e01c45e46$5ad47050$0264a8c0@rck>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <008e01c45e46$5ad47050$0264a8c0@rck>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What can I do ? I'm so desperate that I'm thinking switching to another
> RAID controller. BTW which one of dual-channel U320 with cache have stable
> drivers for x86_64 platform ?

That looks like firmware death to me but Im not the expert, you want to 
ask Mark at adaptec who is chasing down these reports.

As to U320 controllers - I've no real opinion. I'm still at ultra80 8)

