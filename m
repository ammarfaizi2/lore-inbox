Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264421AbTEJQEk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 May 2003 12:04:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTEJQEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 May 2003 12:04:40 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:54144 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S264421AbTEJQEi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 May 2003 12:04:38 -0400
Date: Sat, 10 May 2003 17:17:10 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: CaT <cat@zip.com.au>, Andi Kleen <ak@muc.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
Message-ID: <20030510161710.GC29271@mail.jlokier.co.uk>
References: <20030510025634.GA31713@averell> <20030510033504.GA1789@zip.com.au> <1052578182.16166.6.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1052578182.16166.6.camel@dhcp22.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> At least some SMP boxes freak if you do a poweroff request on CPU != 0

Power-off works on some SMP boxes?

-- Jamie
