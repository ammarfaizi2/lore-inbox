Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262723AbTHUObM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 10:31:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262726AbTHUObM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 10:31:12 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:44300 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S262723AbTHUObL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 10:31:11 -0400
Date: Thu, 21 Aug 2003 16:28:54 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Cc: Andries Brouwer <aebr@win.tue.nl>, Vojtech Pavlik <vojtech@suse.cz>,
       Jamie Lokier <jamie@shareable.org>, Neil Brown <neilb@cse.unsw.edu.au>,
       linux-kernel@vger.kernel.org
Subject: Re: Input issues - key down with no key up
Message-ID: <20030821162854.A3518@pclin040.win.tue.nl>
References: <20030821144441.A3480@pclin040.win.tue.nl> <Pine.GSO.3.96.1030821152921.2489G-100000@delta.ds2.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.GSO.3.96.1030821152921.2489G-100000@delta.ds2.pg.gda.pl>; from macro@ds2.pg.gda.pl on Thu, Aug 21, 2003 at 03:45:15PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 21, 2003 at 03:45:15PM +0200, Maciej W. Rozycki wrote:

>  So if you need these keys, then just use what works for you.

I am not sure what you are discussing.
But I am talking about the Linux keyboard driver.

It must not touch Set 3, or lots of people will have problems.

Only when the user explicitly asks for Set 3 is it reasonable
to switch to it.

