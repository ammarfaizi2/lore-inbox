Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262019AbTINWNE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 18:13:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262021AbTINWNE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 18:13:04 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:929 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262019AbTINWNC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 18:13:02 -0400
Subject: Re: Discourage Uniform Driver Model?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: jimwclark@ntlworld.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <200309142138.32222.jimwclark@ntlworld.com>
References: <200309140027.08610.jimwclark@ntlworld.com>
	 <200309142138.32222.jimwclark@ntlworld.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1063577498.2472.3.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-6) 
Date: Sun, 14 Sep 2003 23:11:39 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-09-14 at 21:38, James Clark wrote:
> 1. If it was possible to create a driver model that allowed module
> compatibility across different releases/revisions without recompilation and
> with minimal performance hit would this be desirable?

We've spent years trying to reduce the number of binary differences.
Since it involves the most basic blocks of code, choice of instructions
it isnt going to be avoidable.

