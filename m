Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264080AbUDFW5R (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Apr 2004 18:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264082AbUDFW5R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Apr 2004 18:57:17 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:5549 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264080AbUDFW5M
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Apr 2004 18:57:12 -0400
Date: Tue, 6 Apr 2004 23:57:11 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Timothy Miller <miller@techsource.com>
Cc: Sergiy Lozovsky <serge_lozovsky@yahoo.com>, root@chaos.analogic.com,
       Horst von Brand <vonbrand@inf.utfsm.cl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: kernel stack challenge
Message-ID: <20040406225711.GM31500@parcelfarce.linux.theplanet.co.uk>
References: <20040406211550.30263.qmail@web40514.mail.yahoo.com> <407332E0.2040809@techsource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <407332E0.2040809@techsource.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 06, 2004 at 06:44:48PM -0400, Timothy Miller wrote:
> >5. Well known. So there would be people around who
> >already know this language and expectations are clear.
> >And there are books around about this language.
> 
> LISP completely violates this requirement.  While I appreciate the power 
> of LISP for abstraction, list processing, and how it lends itself 
> towards many AI-related tasks, it's not a commonly-used language.

Whether it's commonly-used or not, there's another killer problem with LISP -
it's fragmented worse than even Pascal.  And "which subset and extensions
do we have in $IMPLEMENTATION" is worth "which language are we dealing with".
Worse, actually.  If you want a functional language - at least pick a
well-defined one.
