Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263415AbUDPPqu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 11:46:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263500AbUDPPqt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 11:46:49 -0400
Received: from ns.suse.de ([195.135.220.2]:51586 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S263484AbUDPPqg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 11:46:36 -0400
Date: Fri, 16 Apr 2004 17:46:34 +0200
From: Andi Kleen <ak@suse.de>
To: Pavel Machek <pavel@suse.cz>
Cc: discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: [discuss] x86-64 2.4 tree in strict maintenance mode now
Message-Id: <20040416174634.601bee7c.ak@suse.de>
In-Reply-To: <20040416150027.GQ468@openzaurus.ucw.cz>
References: <20040414174353.1dcbda16.ak@suse.de>
	<20040416150027.GQ468@openzaurus.ucw.cz>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 16 Apr 2004 17:00:27 +0200
Pavel Machek <pavel@suse.cz> wrote:

> Hi!
> 
> > I will also not add workarounds for broken hardware to 2.4 anymore unless the change
> > is very simple and obvious (and even then it may be not worth it)
> 
> This looks even more strict than Marcelo's rules... Is it wise?

Marcelo's rules should be the same now for 2.4.27 and later (modulo SATA) 

In fact it has been this way for some time already (except for the IA32e merge,
which was a special case). This announcement just formalizes it. 

-Andi
