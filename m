Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266010AbUEUTlH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266010AbUEUTlH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 15:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266013AbUEUTlH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 15:41:07 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46299 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266010AbUEUTlF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 15:41:05 -0400
Date: Fri, 21 May 2004 16:41:58 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Pablo Castellazzi <law@fisica.edu.uy>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: kernel bug vmscan.c:xxx
Message-ID: <20040521194158.GA25894@logos.cnet>
References: <20040520002422.GA8334@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040520002422.GA8334@localhost>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 09:24:44PM -0300, Pablo Castellazzi wrote:
> under heavy load the machine crash with a kernel bug at vmscan.c: xxx
> 
> running debian woody/sarge with kernel 2.4.26 (vanilla + make-kpkg)
> under heavy load the machine crash with a kernel bug at vmscan.c: xxx.
> the keyboard work but any attemp to login on another virtual terminal
> fails with the same error. (xxx are mostly 389, but others too)

Likely to be hardware problem. Do you happen to have another box around to 
change the harddisk to ? 

You could also try 2.6 on the box -- if it crashes at different places it
could be hardware related.

