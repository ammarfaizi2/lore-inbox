Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262450AbTIUQbf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 12:31:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262451AbTIUQbf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 12:31:35 -0400
Received: from mikonos.cyclades.com.br ([200.230.227.67]:23052 "EHLO
	firewall.cyclades.com.br") by vger.kernel.org with ESMTP
	id S262450AbTIUQbe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 12:31:34 -0400
Date: Sun, 21 Sep 2003 13:34:14 -0300 (BRT)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
X-X-Sender: marcelo@logos.cnet
To: Chris Stromsoe <cbs@cts.ucla.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: oops with 2.4.21
In-Reply-To: <Pine.LNX.4.58.0309161234070.8497@potato.cts.ucla.edu>
Message-ID: <Pine.LNX.4.44.0309211333550.16690-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 16 Sep 2003, Chris Stromsoe wrote:

> I have a machine running 2.4.21 that has been crashing relatively
> regularly.  The following oops appeared in the logs this morning, shortly
> before the machine locked up.  ver_linux and ksymoops out are below.
> 
> Prior to reboot, the console showed
> 
> Code: Kernel BUG in header file at line 66
> Kernel BUG at panic.c: 141!

It seems its bad memory. Please try memtest. 

