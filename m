Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTJTBaT (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 21:30:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262374AbTJTBaT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 21:30:19 -0400
Received: from 87.Red-81-38-202.pooles.rima-tde.net ([81.38.202.87]:20778 "EHLO
	falafell.ghetto") by vger.kernel.org with ESMTP id S262373AbTJTBaQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 21:30:16 -0400
Date: Mon, 20 Oct 2003 03:29:14 +0200
From: Pedro Larroy <piotr@member.fsf.org>
To: Andrew Morton <akpm@osdl.org>
Cc: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG] D-states in test8
Message-ID: <20031020012914.GA1315@81.38.200.176>
Reply-To: piotr@member.fsf.org
References: <20031019205630.GA1153@81.38.200.176> <20031019160127.191a189a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019160127.191a189a.akpm@osdl.org>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 19, 2003 at 04:01:27PM -0700, Andrew Morton wrote:
> Pedro Larroy <piotr@member.fsf.org> wrote:
> >
> > Process just started to get into D state, all subsequent ps got into D.
> >  The first that got into D state was mplayer.
> 
> This might help.
> 
> --- 25/sound/core/pcm_native.c~pcm_native-deadlock-fix	2003-10-19 15:58:31.000000000 -0700


Thanks. Also thanks to wli for the insight.


Regards

-- 
  Pedro Larroy Tovar  |  piotr%member.fsf.org 

Software patents are a threat to innovation in Europe please check: 
	http://www.eurolinux.org/     
