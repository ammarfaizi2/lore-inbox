Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbTDHMqS (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 08:46:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261349AbTDHMqQ (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 08:46:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:63896
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261341AbTDHMqP (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 08:46:15 -0400
Subject: Re: some new remote kernel exploit?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jure Pecar <pegasus@nerv.eu.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030408033315.42f407ec.pegasus@nerv.eu.org>
References: <20030408033315.42f407ec.pegasus@nerv.eu.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1049803162.8113.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Apr 2003 12:59:22 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-04-08 at 02:33, Jure Pecar wrote:
> I'm pretty much without ideas how to track this down ... expect to sit at
> the computer for the next 24h and be ready to start dumping traffic at the
> moment it starts again.

If its an attack, then it would imply someone patched the kernel image 
syscall table stuff or around there and got it wrong, perhaps precisely
because your kernels are custom.

