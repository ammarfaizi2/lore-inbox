Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262450AbSKHVcL>; Fri, 8 Nov 2002 16:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262460AbSKHVbK>; Fri, 8 Nov 2002 16:31:10 -0500
Received: from [195.39.17.254] ([195.39.17.254]:12548 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262450AbSKHVbI>;
	Fri, 8 Nov 2002 16:31:08 -0500
Date: Wed, 16 Jan 2002 14:28:20 -0500
From: Pavel Machek <pavel@ucw.cz>
To: Paul Larson <plars@linuxtestproject.org>
Cc: Frank Cornelis <fcorneli@elis.rug.ac.be>,
       lkml <linux-kernel@vger.kernel.org>,
       Frank Cornelis <fcorneli@trappist.elis.rug.ac.be>
Subject: Re: [PATCH] extended ptrace
Message-ID: <20020116192812.GB2947@zaurus>
References: <Pine.LNX.4.44.0210231656080.19811-100000@trappist.elis.rug.ac.be> <1035387198.3447.39.camel@plars>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1035387198.3447.39.camel@plars>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Do you (or anyone else) have any good tests for this, or even ptrace in
> general?  I'm working on some ptrace tests for LTP, but if someone
> already has something to contribute it would save me some time. :)

You may try to use subterfugue.sf.net to stress ptrace....
				Pavel
