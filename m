Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272963AbTHPOlz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 10:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272972AbTHPOlz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 10:41:55 -0400
Received: from h234n2fls24o900.bredband.comhem.se ([217.208.132.234]:15327
	"EHLO oden.fish.net") by vger.kernel.org with ESMTP id S272963AbTHPOlw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 10:41:52 -0400
Date: Sat, 16 Aug 2003 16:44:27 +0200
From: Voluspa <lista1@telia.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] O16.2int
Message-Id: <20030816164427.5c73ff7d.lista1@telia.com>
In-Reply-To: <200308170009.06461.kernel@kolivas.org>
References: <20030816130735.3ec67ac9.lista1@telia.com>
	<200308170009.06461.kernel@kolivas.org>
Organization: The Foggy One
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Aug 2003 00:09:06 +1000 Con Kolivas wrote:

> On Sat, 16 Aug 2003 21:07, Voluspa wrote:
> > On 2003-08-16 8:59:48 Con Kolivas wrote:
[...]
> Funny you should mention xmms in the same sentence since that's an app
> that works fine.
[...]
> Now you have to clarify what you mean by game test as being
> impossible. I assume you mean wine based games?
[...]
> If you can profile blender sucking it would be helpful.

I can still starve xmms while running Blender ;-) Game-test
(yes, wine) impossible means it acts almost exactly as I wrote about in:

http://marc.theaimsgroup.com/?l=linux-kernel&m=106098091012383&w=2

We're talking many minutes of total starvation at each stage, start
- menu selection single player - load saved game menu - load game
(haven't had the patience to wait for an actual game to begin...)

Profile Blender? Ok, know nothing about the technique but will compile a
kernel with profiling and read up on what has been mentioned on this
list (Mr Erwin calling for proper "instrumentation")

Will take alot of time. I'll return any restults directly to your
address, won't copy lkml.

Mvh
Mats Johannesson
