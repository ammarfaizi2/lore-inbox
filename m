Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264202AbTFPTre (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 15:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264208AbTFPTre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 15:47:34 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:28549 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264202AbTFPTrd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 15:47:33 -0400
Date: Mon, 16 Jun 2003 22:05:10 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: Timothy Miller <miller@techsource.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Coding technique question
In-Reply-To: <3EEE2293.6010304@techsource.com>
Message-ID: <Pine.LNX.4.44.0306162202480.1924-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jun 2003, Timothy Miller wrote:

> I believe I've seen this sort of thing done in the kernel:
> 
> do {
>      ....
>      code
>      ....
> } while (0);
> 
> 
> What I was wondering is how this is any different from:
> 
> {
>      ....
>      code
>      ....
> }

See the Kernel Newbies FAQ at http://kernelnewbies.org/faq/
Q: "Why do a lot of #defines in the kernel use do { ... } while(0)? "
 
Best regards,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
Bedrijvenpark Twente 305         NL-7602 KL Almelo - the Netherlands
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
a.marsman@aYniK.com              http://www.aYniK.com

