Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161334AbWASTPp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161334AbWASTPp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 14:15:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161330AbWASTPp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 14:15:45 -0500
Received: from mx1.redhat.com ([66.187.233.31]:43226 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161334AbWASTPn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 14:15:43 -0500
Date: Thu, 19 Jan 2006 14:13:18 -0500
From: Dave Jones <davej@redhat.com>
To: Nick <nick@linicks.net>
Cc: Krzysztof Halasa <khc@pm.waw.pl>, Jesper Juhl <jesper.juhl@gmail.com>,
       Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
       torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] offer CC_OPTIMIZE_FOR_SIZE only if EXPERIMENTAL
Message-ID: <20060119191317.GH21663@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>, Nick <nick@linicks.net>,
	Krzysztof Halasa <khc@pm.waw.pl>,
	Jesper Juhl <jesper.juhl@gmail.com>, Adrian Bunk <bunk@stusta.de>,
	Andrew Morton <akpm@osdl.org>, torvalds@osdl.org,
	linux-kernel@vger.kernel.org
References: <20051214191006.GC23349@stusta.de> <20051214140531.7614152d.akpm@osdl.org> <20051214221304.GE23349@stusta.de> <9a8748490512141418w2a3811a9iffe83b5f285e2910@mail.gmail.com> <9a8748490512141428q29f39ca5x66d2c52e22aa9208@mail.gmail.com> <20051215004006.GA19354@redhat.com> <m3bqzijtev.fsf@defiant.localdomain> <7c3341450601191017o796faf45r2cc5c8e544dcfe11@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c3341450601191017o796faf45r2cc5c8e544dcfe11@mail.gmail.com>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2006 at 06:17:56PM +0000, Nick wrote:

 > > Version-Release number of selected component (if applicable):
 > > gcc-4.0.1-4.fc4 and gcc-4.0.2-8.fc4 (i.e., FC4-current)
 > >
 > 
 > I use Os on all my builds of everything, including the option for the kernel
 > - that bug doesn't hit me on (heavily updated) Slackware 10, and I have
 > never seen no ill effect:
 > 
 > gcc version 3.3.4

It's a regression introduced in gcc4

		Dave
