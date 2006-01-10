Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWAJOQL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWAJOQL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jan 2006 09:16:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932163AbWAJOQL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jan 2006 09:16:11 -0500
Received: from relay01.pair.com ([209.68.5.15]:57863 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S932132AbWAJOQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jan 2006 09:16:10 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
To: Tim Tassonis <timtas@cubic.ch>
Subject: Re: State of the Union: Wireless
Date: Tue, 10 Jan 2006 08:16:26 -0600
User-Agent: KMail/1.9
Cc: linux-kernel@vger.kernel.org
References: <43C3AAE2.1090900@cubic.ch>
In-Reply-To: <43C3AAE2.1090900@cubic.ch>
Organization: Clientec, Inc.
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601100816.26975.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 10 January 2006 06:38, Tim Tassonis wrote:
> This is exactly the opposite of what Linus proposes in his management
> style document: "Avoid making decisions". At the moment, nobody seems to
> know what the "right" direction is, because the right direction is the
> one that will produce the better wireless support, and not the one that
> sounds better at the moment.

I won't try to speak for Linus (perhaps he'd like to pipe up at some point), 
but I think you're pulling that concept wayy out of context here.

Quoting ManagementStyle:

> Btw, another way to avoid a decision is to plaintively just whine "can't
> we just do both?" and look pitiful.  Trust me, it works.  If it's not
> clear which approach is better, they'll eventually figure it out.  The
> answer may end up being that both teams get so frustrated by the
> situation that they just give up.

Built into that paragraph, I think, is the assumption that you never 'do 
both'. 

Also, referring to OSS/Alsa is just a great way to illustrate the problem with 
your idea. There is, today, finally a "dominant" solution, but how long did 
it take us to get there? By my count, a really long time! And along the way 
we've had to deal with all kinds of applications that just support the first 
and not the other. And it seems like far too many people still have just one 
foot in the door - take for instance the README files shipped with commercial 
game ports that advise using OSS at the first hint of trouble with Alsa.

Is this what we want for wireless?

>
> Tim
>

Chase
