Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270749AbTHGV0R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 17:26:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270864AbTHGV0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 17:26:17 -0400
Received: from fw.osdl.org ([65.172.181.6]:63702 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270749AbTHGV0P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 17:26:15 -0400
Date: Thu, 7 Aug 2003 14:28:07 -0700
From: Andrew Morton <akpm@osdl.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test2-mm5
Message-Id: <20030807142807.3e4a284c.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0308071819380.4791-100000@logos.cnet>
References: <20030806223716.26af3255.akpm@osdl.org>
	<Pine.LNX.4.44.0308071819380.4791-100000@logos.cnet>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti <marcelo@conectiva.com.br> wrote:
>
> PCI: Using configuration type 1
> 
> 
>  Locked up solid there. Want more info ? 

doh.  I don't even know who to lart for that one!

Could you please boot with "initcall_debug" and then resolve the final
couple of addresses in System.map?  That'll narrow it down.

