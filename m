Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270885AbTGVPr4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Jul 2003 11:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270886AbTGVPr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Jul 2003 11:47:56 -0400
Received: from doublethink.psax.org ([66.93.167.166]:27274 "EHLO
	kilgore.psax.org") by vger.kernel.org with ESMTP id S270885AbTGVPrz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Jul 2003 11:47:55 -0400
Date: Tue, 22 Jul 2003 09:02:42 -0700
From: Dave Barry <dave@mikamyla.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: no EMU10k1 Sound on 2.6.0-test1-ac2
Message-ID: <20030722160242.GA23041@mikamyla.com>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>
References: <1058867364.13457.4.camel@garaged.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1058867364.13457.4.camel@garaged.homeip.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quothe Max Valdez <maxvaldez@yahoo.com>, on Tue, Jul 22, 2003:
> Hi,
> 
> Is anybody having problems with alsa sound on 2.6.0-test1-ac2 ??
> 
> I have all my modules mounted, and this time, I can even look the tree
> with lsmod (couldnt do it with any other 2.5.X or 2.6-0-test1). But my
> speakears dont get any signal :-(.
> 
> Sound worked perfect on test1-ac1. and test1 too.

Hi, 

This may not help, but on my system, I had to use alsamixer to mute the
digital out channel (which was enabled by default) to hear sound via the
analog channels.

-- 
Dave Barry
dave@mikamyla.com
