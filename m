Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262142AbTEZPOH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 May 2003 11:14:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262143AbTEZPOH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 May 2003 11:14:07 -0400
Received: from smtp-out2.iol.cz ([194.228.2.87]:31420 "EHLO smtp-out2.iol.cz")
	by vger.kernel.org with ESMTP id S262000AbTEZPOG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 May 2003 11:14:06 -0400
Date: Sun, 25 May 2003 23:52:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: jpo234@netscape.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dead machine, blinking Keyboard and no Oops on console
Message-ID: <20030525215211.GA26365@elf.ucw.cz>
References: <418FE1FC.68D97D6D.00065BAA@netscape.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <418FE1FC.68D97D6D.00065BAA@netscape.net>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> >Blinking keyboard lights means kernel panic.
> >
> >    Jeff
> 
> Shouldn't a panic cause some message on the console?
> Does the missing message provide a clue?

I'd go for serial console at this point...
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
