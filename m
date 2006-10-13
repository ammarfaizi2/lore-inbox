Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750864AbWJMJUy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750864AbWJMJUy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 05:20:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750969AbWJMJUy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 05:20:54 -0400
Received: from pythagoras.zen.co.uk ([212.23.3.140]:44242 "EHLO
	pythagoras.zen.co.uk") by vger.kernel.org with ESMTP
	id S1750864AbWJMJUy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 05:20:54 -0400
From: David Johnson <dj@david-web.co.uk>
To: Jarek Poplawski <jarkao2@o2.pl>
Subject: Re: Hardware bug or kernel bug?
Date: Fri, 13 Oct 2006 10:20:48 +0100
User-Agent: KMail/1.9.5
References: <20061013085605.GA1690@ff.dom.local>
In-Reply-To: <20061013085605.GA1690@ff.dom.local>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610131020.48232.dj@david-web.co.uk>
X-Originating-Pythagoras-IP: [82.69.29.67]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 October 2006 09:56, Jarek Poplawski wrote:
>
> I'd try with this:
> - minimal workable config with a lot of debugging turned on (e.g. no:
> smp, floppy, parport, mouse, ipv6, video, clock modulation, apm, acpi
> buttons, thermal etc. - only base acpi or no if possible),
> - 2.4 kernel,
> - other distro e.g. live-cd knoppix,
> - other transfer method like ftp (all superfluous services turned off).
>

I'll give that a go and I guess I should also see whether I can reproduce it 
under Windows too...

Cheers,
David.
