Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272169AbTG2XP1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jul 2003 19:15:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272216AbTG2XP1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jul 2003 19:15:27 -0400
Received: from co239024-a.almel1.ov.home.nl ([217.120.226.100]:6798 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S272169AbTG2XPY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jul 2003 19:15:24 -0400
Date: Wed, 30 Jul 2003 01:13:39 +0200 (CEST)
From: Aschwin Marsman <a.marsman@aYniK.com>
X-X-Sender: marsman@localhost.localdomain
To: Marcelo Tosatti <marcelo@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.22-pre9
In-Reply-To: <Pine.LNX.4.55L.0307291700490.24730@freak.distro.conectiva>
Message-ID: <Pine.LNX.4.44.0307300108390.1819-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 29 Jul 2003, Marcelo Tosatti wrote:

> 
> Hi,
> 
> Here goes -pre9, yet another step in 2.4.22 direction.

Thanks. When using "make oldconfig", every time I have to press
enter to continue for:
  BT848 Video For Linux (CONFIG_VIDEO_BT848) [N/m/?] (NEW) 
This is the case for the last couple of pre releases I tested (currently using
pre8 & compiling pre9). It looks like the option is not saved in the
.config file.

Otherwise the compilation with my .config works without human intervention.

> It contains a bunch of Netfilter fixes, set of IEEE1394 fixes, couple of
> knfsd fixes amongst others.
> 
> Expect -pre10 tomorrow.
 
I will reserve some CPU cycles.

Have fun,
 
Aschwin Marsman
 
--
aYniK Software Solutions         all You need is Knowledge
P.O. box 134                     NL-7600 AC Almelo - the Netherlands
a.marsman@aYniK.com              http://www.aYniK.com

