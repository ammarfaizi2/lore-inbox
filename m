Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266673AbUFWUxE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266673AbUFWUxE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 16:53:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266675AbUFWUxE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 16:53:04 -0400
Received: from fw.osdl.org ([65.172.181.6]:60818 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266673AbUFWUw6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 16:52:58 -0400
Date: Wed, 23 Jun 2004 13:55:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Christoph Hellwig <hch@infradead.org>
Cc: ks@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: Re: Why dentry->d_qstr change in 2.6.7 ?
Message-Id: <20040623135537.3e4f4072.akpm@osdl.org>
In-Reply-To: <20040623141027.GA23278@infradead.org>
References: <1087660293.30405.47.camel@localhost>
	<1087999469.10863.0.camel@localhost>
	<20040623141027.GA23278@infradead.org>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> On Wed, Jun 23, 2004 at 04:04:29PM +0200, Kristian Sørensen wrote:
> > Can it really be, that noone knows why this change has been made !??
> 
> There's certainly people who know.  Look into the changelog to read
> what they have to say.
> 

afaik there is no way to obtain changelog information from the BK web
interface, which is a significant shortcoming.
