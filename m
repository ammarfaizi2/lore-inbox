Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbTIUPQf (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Sep 2003 11:16:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbTIUPQf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Sep 2003 11:16:35 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:46596 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262427AbTIUPQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Sep 2003 11:16:33 -0400
Date: Sun, 21 Sep 2003 17:16:32 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org,
       John Bradford <john@grabjohn.com>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards
Message-ID: <20030921171632.A11359@pclin040.win.tue.nl>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030921110125.GB18677@ucw.cz> <0a5f01c38043$f9c35c80$44ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0a5f01c38043$f9c35c80$44ee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Sun, Sep 21, 2003 at 10:26:04PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 21, 2003 at 10:26:04PM +0900, Norman Diamond wrote:

[good description of Japanese keyboards deleted]

> > If anyone would send me samples of Japanese keyboards, you can be sure
> > I'd test them.
> 
> Thank you!  I was afraid to ask in advance because I thought that you would
> either refuse or you would ignore the suggestion.  Dr. Brouwer did refuse,
> about 3 years ago or so.

Did I really?

But the advantage of a good description is that the information
lives on the net and can be retrieved by anybody. A piece of
hardware takes room and can be tested by only one.

I think no kernel changes are required to use Japanese keyboards today.
(But kbd has to be recompiled with NR_KEYS set to 256.)

Andries


On http://www.win.tue.nl/~aeb/linux/kbd/scancodes-6.html
there is a reasonably detailed description of the state of
affairs. Maybe nothing more is needed. Of course additions
and corrections are welcome.

