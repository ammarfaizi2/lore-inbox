Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbTKQX7a (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 18:59:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262161AbTKQX7a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 18:59:30 -0500
Received: from serenity.mcc.ac.uk ([130.88.200.93]:25351 "EHLO
	serenity.mcc.ac.uk") by vger.kernel.org with ESMTP id S262130AbTKQX73
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 18:59:29 -0500
Date: Mon, 17 Nov 2003 23:59:27 +0000
From: John Levon <levon@movementarian.org>
To: "Wojciech 'Sas' Cieciwa" <cieciwa@alpha.zarz.agh.edu.pl>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: HOWTO build modules in 2.6.0 ...
Message-ID: <20031117235927.GA31611@compsoc.man.ac.uk>
References: <Pine.LNX.4.58L.0311171939150.25906@alpha.zarz.agh.edu.pl> <20031117203336.GA1714@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031117203336.GA1714@mars.ravnborg.org>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: King of Woolworths - L'Illustration Musicale
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *1ALtHD-0000os-Kw*42r9e297ju6*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 17, 2003 at 09:33:36PM +0100, Sam Ravnborg wrote:

> Use the following:
> make -C /usr/src/linux SUBDIRS=`pwd` O=/users/cieciwa/rpm/BUILD/eagle-1.0.4/linux modules
> 

This requires a kernel source tree empty of built files though, so it's
really not a great solution ...

regards
john
-- 
Khendon's Law:
If the same point is made twice by the same person, the thread is over.
