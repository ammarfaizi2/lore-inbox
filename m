Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272824AbTHSQ5S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Aug 2003 12:57:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272816AbTHSQ5S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Aug 2003 12:57:18 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:43649 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S276366AbTHSQaj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Aug 2003 12:30:39 -0400
Date: Tue, 19 Aug 2003 17:30:34 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: Paolo Ornati <javaman@katamail.com>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Documentation for PC Architecture
Message-ID: <20030819163034.GA15033@mail.jlokier.co.uk>
References: <20030819010205.GE11081@mail.jlokier.co.uk> <Pine.LNX.4.44.0308182202550.27238-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308182202550.27238-100000@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nagendra Singh Tomar wrote:
> 	What is this 2nd address translation you are mentioning. 
> I always thought that for the sake of cleanliness we just forget about the 
> 384K of memory starting from 640K. RAM anyway is cheap.
> Pl correct me if I'm missing something.

That is probably true of modern machines.  It is hard to tell from the
e820 map on two machines I just looked at, because other bits of RAM
are missing, more than 384k.

The original question asked about "the PC architecture", and I can say
for sure that a PC with 1MB does not just forget about 384k of it :)

-- Jamie
