Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030344AbWGZRgS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030344AbWGZRgS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jul 2006 13:36:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030345AbWGZRgS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jul 2006 13:36:18 -0400
Received: from mail.gmx.de ([213.165.64.21]:58556 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S1030344AbWGZRgS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jul 2006 13:36:18 -0400
X-Authenticated: #1490710
Date: Wed, 26 Jul 2006 19:36:16 +0200 (CEST)
From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
To: Linus Torvalds <torvalds@osdl.org>
cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Nasty git corruption problem
In-Reply-To: <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org>
Message-ID: <Pine.LNX.4.63.0607261935160.29667@wbgn013.biozentrum.uni-wuerzburg.de>
References: <1153929715.13509.12.camel@localhost.localdomain>
 <Pine.LNX.4.64.0607260945440.29649@g5.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 26 Jul 2006, Linus Torvalds wrote:

> Well, the "dangling objects" really should be the fix. We could make it 
> even more obvious by creating links to the dangling objects in a 
> "lost+found" directory, but I usually just do it by hand.

We _do_ have git-lost-found.sh.

Hth,
Dscho

