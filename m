Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262437AbTFGAmi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jun 2003 20:42:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262439AbTFGAmi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jun 2003 20:42:38 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34452
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262437AbTFGAmh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jun 2003 20:42:37 -0400
Subject: Re: help: use of third party kernel modules: license issue?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: J C <jclp12@hotmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Law14-F14xxnSYe4nhr00045290@hotmail.com>
References: <Law14-F14xxnSYe4nhr00045290@hotmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1054947225.17185.26.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 07 Jun 2003 01:53:45 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2003-06-07 at 00:57, J C wrote:
> How does the Linux GPL license apply to third party, binary modules in
> a case where our custom core kernel code uses proprietary, third
> party, "binary only" module interfaces?

Linux the kernel is subject to the GPL license. The GPL license is 
absolutely clear what it applies to, which is any derivative work.

So the question you need to answer is "Is this a derivative work". For
user space its easy and to be clear the kernel explicitly clarifies it
doesn't regard user space as that. For kernel changes its a hard
question and you need to ask someone who studies the issue - thats not
a programmer (we just think we know ;)) but a lawyer.


