Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751699AbWAaWhE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751699AbWAaWhE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 17:37:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751702AbWAaWhE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 17:37:04 -0500
Received: from wproxy.gmail.com ([64.233.184.197]:21637 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751699AbWAaWhC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 17:37:02 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=gqr3ph8+0X6q78N0G+G4sjI9N8JAEicMVv/yYJ1ONpgWkxdRuTNjZvrwo3zf2I40V2b/vtR7B5if6mvubqzOYFbTdILrxtnN56dvf2KsYwJNVGx7FxSOHV88+tvrG0hMVPQF6A/jMb4rGJw9qB6esfBoARsnq+zz6DbAaa47zCs=
Message-ID: <eb0e02f40601311437g2f15a6d8oaca2be2b67954b9b@mail.gmail.com>
Date: Wed, 1 Feb 2006 09:37:01 +1100
From: Grant Coady <gcoady@gmail.com>
To: Jacek Lipkowski <sq5bpf@acid.ch.pw.edu.pl>
Subject: Re: patch to make 2.4.32 work on i486 again
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0601312313050.6477@acid.ch.pw.edu.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <Pine.LNX.4.58.0601312313050.6477@acid.ch.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/1/06, Jacek Lipkowski <sq5bpf@acid.ch.pw.edu.pl> wrote:
> Booting the 2.4.32 kernel compiled for a i486 on an i486 box fails,
> because "Kernel compiled for Pentium+, requires TSC feature!" (printed
> from check_config() include/asm-i386/bugs.h). To reproduce, select 486 in
> the kernel configuration and grep CONFIG_X86_TSC .config
>
> Seems strange that no one noticed this, am i the only one still using 486
> boxes? :)

I keep old stuff going, but no i486 mobo's here :(

Grant.
