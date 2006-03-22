Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750815AbWCVMGI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750815AbWCVMGI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 07:06:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750826AbWCVMGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 07:06:08 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:34970 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750815AbWCVMGH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 07:06:07 -0500
Subject: Re: [PATCH 000/141] V4L/DVB updates part 1
From: Mauro Carvalho Chehab <mchehab@infradead.org>
To: Daniel Barkalow <barkalow@iabervon.org>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       linux-dvb-maintainer@linuxtv.org, video4linux-list@redhat.com,
       akpm@osdl.org
In-Reply-To: <Pine.LNX.4.64.0603211829430.6773@iabervon.org>
References: <20060320150819.PS760228000000@infradead.org>
	 <Pine.LNX.4.64.0603210741120.3622@g5.osdl.org>
	 <Pine.LNX.4.64.0603210748340.3622@g5.osdl.org>
	 <1142962995.4749.39.camel@praia>
	 <Pine.LNX.4.64.0603210946040.3622@g5.osdl.org>
	 <1142965478.4749.58.camel@praia>
	 <Pine.LNX.4.64.0603211035390.3622@g5.osdl.org>
	 <1142968537.4749.96.camel@praia>
	 <Pine.LNX.4.64.0603211126290.3622@g5.osdl.org>
	 <Pine.LNX.4.64.0603211829430.6773@iabervon.org>
Content-Type: text/plain; charset=ISO-8859-1
Date: Wed, 22 Mar 2006 09:05:55 -0300
Message-Id: <1143029155.5854.10.camel@praia>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.2.1-3mdk 
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <mchehab@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Ter, 2006-03-21 às 18:53 -0500, Daniel Barkalow escreveu:
> On Tue, 21 Mar 2006, Linus Torvalds wrote:

> Isn't this what you'd get if you accidentally removed .git/MERGE_HEAD 
> while trying to resolve a merge, and then absent-mindedly described what 
> you'd done in the commit message (forgetting that it ought to have 
> generated the commit message for you in this situation)?
For sure I didn't this by hand. The only possibility is that git, for
some unknown reason, decided to remove it by itself. Maybe another git
command in-between git pull and git commit might do it, without
reverting to its previous state?

Cheers, 
Mauro.

