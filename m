Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263318AbTIVUO5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 16:14:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263319AbTIVUO5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 16:14:57 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:23826 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S263318AbTIVUO4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 16:14:56 -0400
Date: Mon, 22 Sep 2003 22:14:53 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       linux-kernel@vger.kernel.org, John Bradford <john@grabjohn.com>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards
Message-ID: <20030922221453.A1064@pclin040.win.tue.nl>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030921110125.GB18677@ucw.cz> <0a5f01c38043$f9c35c80$44ee4ca5@DIAMONDLX60> <20030921171632.A11359@pclin040.win.tue.nl> <0c2001c38104$34c2a690$44ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <0c2001c38104$34c2a690$44ee4ca5@DIAMONDLX60>; from ndiamond@wta.att.ne.jp on Mon, Sep 22, 2003 at 09:21:53PM +0900
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 22, 2003 at 09:21:53PM +0900, Norman Diamond wrote:

> > I think no kernel changes are required to use Japanese keyboards today.
> > (But kbd has to be recompiled with NR_KEYS set to 256.)
> 
> I'm not convinced yet.  defkeymap.c_shipped is included in the downloadable
> .bz2 file and it is inadequate.

But defkeymap is inadequeate for German, it is inadequate for French,
why would it be adequate for Japanese?

It is just the random default you get when no keymap was loaded.

