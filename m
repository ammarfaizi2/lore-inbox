Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262639AbUCLXxk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 18:53:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262638AbUCLXxk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 18:53:40 -0500
Received: from fw.osdl.org ([65.172.181.6]:3290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262639AbUCLXxj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 18:53:39 -0500
Date: Fri, 12 Mar 2004 15:55:40 -0800
From: Andrew Morton <akpm@osdl.org>
To: Subodh Shrivastava <subodh@btopenworld.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.4-mm1
Message-Id: <20040312155540.724dcc56.akpm@osdl.org>
In-Reply-To: <40524208.3000207@btopenworld.com>
References: <40524208.3000207@btopenworld.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subodh Shrivastava <subodh@btopenworld.com> wrote:
>
> I am able to boot vanilla kernel without the following option enabled
> 
> CONFIG_PCI_USE_VECTOR
> 
> If i don't enable the above mentioned option 2.6.4-mm1 won't boot on my 

       ^^^^^ "do", I assume?

> Laptop

Is this unique to 2.6.4-mm1 or does 2.6.4 do the same thing?
