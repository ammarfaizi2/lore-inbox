Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265659AbUBBJXJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 04:23:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265669AbUBBJXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 04:23:09 -0500
Received: from twilight.ucw.cz ([81.30.235.3]:52608 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S265659AbUBBJXH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 04:23:07 -0500
Date: Mon, 2 Feb 2004 10:23:18 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: Valdis.Kletnieks@vt.edu
Cc: Joshua Kwan <joshk@triplehelix.org>, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: 2.6 input drivers FAQ
Message-ID: <20040202092318.GD548@ucw.cz>
References: <20040201100644.GA2201@ucw.cz> <20040201163136.GF11391@triplehelix.org> <200402020527.i125RvTx008088@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402020527.i125RvTx008088@turing-police.cc.vt.edu>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 02, 2004 at 12:27:57AM -0500, Valdis.Kletnieks@vt.edu wrote:
> On Sun, 01 Feb 2004 08:31:37 PST, Joshua Kwan said:
> 
> > On Sun, Feb 01, 2004 at 11:06:44AM +0100, Vojtech Pavlik wrote:
> > > I'm getting double clicks when I click only once.
> > 
> > I get these spuriously and i'm using only /dev/input/mice in my config
> > flie.
> 
> OK.. and here I thought I was getting senile or Mozilla was buggy. Every
> once in a while (a few times a day at most) I'd middle-click a link to open it
> in a new tab, and get 2 tabs.
> 
> It may affect left-button as well, I don't often do things where a single
> or double left-click produce different noticably results.

Are you sure you don't have the mouse configured twice in XFree86
config? It's a rather common error.

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
