Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273032AbTGaODg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 10:03:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S273033AbTGaODg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 10:03:36 -0400
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:51972 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S273032AbTGaODf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 10:03:35 -0400
Date: Thu, 31 Jul 2003 16:03:34 +0200
From: Pavel Machek <pavel@suse.cz>
To: Andre Hedrick <andre@linux-ide.org>
Cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       alan@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: Warn about taskfile?
Message-ID: <20030731140334.GA16463@atrey.karlin.mff.cuni.cz>
References: <20030731102827.GD464@elf.ucw.cz> <Pine.LNX.4.10.10307310557570.19607-100000@master.linux-ide.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.10.10307310557570.19607-100000@master.linux-ide.org>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Did you bother to turn off the suspend to death?  Since it appears to do
> all kinds of orthoginal operations to the state machine?

No, sorry. Corruption is slow, it took week last time... No, I did not
disable suspend, and it is possible that swsusp and/or loop and/or me
is to blame.
								Pavel
-- 
Horseback riding is like software...
...vgf orggre jura vgf serr.
