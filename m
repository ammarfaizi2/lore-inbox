Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262602AbVAEUKh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262602AbVAEUKh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 15:10:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262582AbVAEUGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 15:06:50 -0500
Received: from prosun.first.fraunhofer.de ([194.95.168.2]:27059 "EHLO
	prosun.first.fraunhofer.de") by vger.kernel.org with ESMTP
	id S262580AbVAEUGo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 15:06:44 -0500
Subject: Re: [BUG] 2.6.10-rc3 snd-powermac crash
From: Soeren Sonnenburg <kernel@nn7.de>
To: Andreas Schwab <schwab@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <jezmzuo5jc.fsf@sykes.suse.de>
References: <1103389648.5967.7.camel@gaston>
	 <pan.2004.12.21.07.53.37.708238@nn7.de>  <jezmzuo5jc.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Wed, 05 Jan 2005 21:06:13 +0100
Message-Id: <1104955573.10297.27.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-31 at 16:23 +0100, Andreas Schwab wrote:
> Soeren Sonnenburg <kernel@nn7.de> writes:
> 
> > I also get the very same oops - though very rarely - with pbbuttons and
> > kernel 2.6.9 on my 1GHz-pbook 15"
> 
> I have been using ALSA on my G3 iBook already for a long time and never
> saw this.  I didn't try 2.6.10 yet, though.

FYI: I have been running 2.6.10 (which includes bens alsa ppc fix) since
it was released... no oopses no crashes so far.

Soeren (happy)
-- 
Sometimes, there's a moment as you're waking, when you become aware of
the real world around you, but you're still dreaming.

