Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265571AbTFMXbR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 19:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265581AbTFMXbQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 19:31:16 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:44039 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265571AbTFMXbQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 19:31:16 -0400
Date: Sat, 14 Jun 2003 00:43:52 +0100 (BST)
From: James Simmons <jsimmons@infradead.org>
To: Svetoslav Slavtchev <galia@st-peter.stw.uni-erlangen.de>
cc: Linux console project <linuxconsole-dev@lists.sourceforge.net>,
       <Aivils.Stoss@unibanka.lv>, <andreas@schuldei.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: is Ruby dead ? lkml: Real multi-user linux
In-Reply-To: <1055547152.3eea5f106e9a5@secure.st-peter.stw.uni-erlangen.de>
Message-ID: <Pine.LNX.4.44.0306140036470.29353-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I was wonderin what does this post by James Simmons means.
> 
> James did you abondon ruby in order to bring something comersial ?
> there are no changes in ruby for a more then 4 monts,
> and ruby is hardly useable/ compilable, and you are talking about
> a production status?

The 2.5.X version is broken. Instead I have beening working on making
the fbdev layer stable. The api I developed while working on ruby. The 
2.4.X version is quite stable. Alot of the framebuffer drivers could be 
dropped onto the 2.4.X ruby kernel and it would work. We do have a few 
changes in the framebuffer api that happened but that wouldn't take much 
to port to ruby 2.4.X.

> did i misunderstood something, or you have droped ruby for something comersial?

No. I'm still working on ruby. All my 2.5.X is geared toward ruby.
 

