Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292214AbSBOWEl>; Fri, 15 Feb 2002 17:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292212AbSBOWEb>; Fri, 15 Feb 2002 17:04:31 -0500
Received: from zero.tech9.net ([209.61.188.187]:38927 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S292211AbSBOWER> convert rfc822-to-8bit;
	Fri, 15 Feb 2002 17:04:17 -0500
Subject: Re: [PATCH] fix xconfig in 2.5.4-dj2
From: Robert Love <rml@tech9.net>
To: =?ISO-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc: Dave Jones <davej@suse.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20020215230739.33e22865.l.s.r@web.de>
In-Reply-To: <20020215230739.33e22865.l.s.r@web.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Mailer: Evolution/1.0.2 
Date: 15 Feb 2002 17:02:55 -0500
Message-Id: <1013810576.803.1048.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-02-15 at 17:07, René Scharfe wrote:

> patch below allows 'make xconfig' to run successfully.

I believe this is a bug in 2.5.5-pre1, so Dave just picked it up from
there.  I recall seeing a merge from Linus in his BK changelog for a fix
in pre2, too.

	Robert Love

