Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVBIFE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVBIFE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Feb 2005 00:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261786AbVBIFE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Feb 2005 00:04:28 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:36983 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261785AbVBIFEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Feb 2005 00:04:24 -0500
Date: Wed, 9 Feb 2005 06:04:32 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kai Germaschewski <kai.germaschewski@unh.edu>
Cc: Sam Ravnborg <sam@ravnborg.org>, Matthew Wilcox <matthew@wil.cx>,
       Roman Zippel <zippel@linux-m68k.org>,
       Kai Germaschewski <kai@germaschewski.name>,
       linux-kernel@vger.kernel.org, dholland@eecs.harvard.edu
Subject: Re: [PATCH] Makefiles are not built using a Fortran compiler
Message-ID: <20050209050432.GA8171@mars.ravnborg.org>
Mail-Followup-To: Kai Germaschewski <kai.germaschewski@unh.edu>,
	Sam Ravnborg <sam@ravnborg.org>, Matthew Wilcox <matthew@wil.cx>,
	Roman Zippel <zippel@linux-m68k.org>,
	Kai Germaschewski <kai@germaschewski.name>,
	linux-kernel@vger.kernel.org, dholland@eecs.harvard.edu
References: <20050208192027.GA8360@mars.ravnborg.org> <Pine.LNX.4.44.0502081423470.30718-100000@chaos.sr.unh.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0502081423470.30718-100000@chaos.sr.unh.edu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai - long time..

> > The SCCS rules is the sole reason why -rR has not been enabled.
> 
> An easy way to make sure that the SCCS business is not a factor would be 
> to explicitly put the SCCS rules into the Makefile -- it's just two lines.

Yup, I will do that when 2.6.11 opens up.
If other rules are needed I will add them.

	Sam
