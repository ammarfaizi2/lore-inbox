Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270475AbTGSCoe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 22:44:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270479AbTGSCoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 22:44:34 -0400
Received: from fw.osdl.org ([65.172.181.6]:64733 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270475AbTGSCod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 22:44:33 -0400
Date: Fri, 18 Jul 2003 20:00:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: James Bourne <jbourne@hardrock.org>
Cc: breed@users.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [BUG REPORT 2.6.0] cisco airo_cs scheduling while atomic
Message-Id: <20030718200013.40e983f6.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307182044420.22990-100000@cafe.hardrock.org>
References: <20030718140414.371cdb55.akpm@osdl.org>
	<Pine.LNX.4.44.0307182044420.22990-100000@cafe.hardrock.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bourne <jbourne@hardrock.org> wrote:
>
> > I've been waiting months for someone to test this patch.  Can you please do
>  > so?
> 
>  Well, the error is gone, unfortunately I won't have anything for the card to
>  talk to until monday (or if I take my laptop for a car ride...).

Well Daniel Ritz has posted a big fix to the driver so I threw mine away. 
I'll include it in the next -mm, so please test that.

