Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbTLWBGt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Dec 2003 20:06:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264877AbTLWBGs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Dec 2003 20:06:48 -0500
Received: from amber.ccs.neu.edu ([129.10.116.51]:61906 "EHLO
	amber.ccs.neu.edu") by vger.kernel.org with ESMTP id S264875AbTLWBGr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Dec 2003 20:06:47 -0500
Subject: Re: Badness in pci_find_subsys & sleeping function called from
	invalid context
From: Stan Bubrouski <stan@ccs.neu.edu>
To: Jesper Juhl <juhl@dif.dk>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.56.0312222016530.27724@jju_lnx.backbone.dif.dk>
References: <Pine.LNX.4.56.0312221959460.27724@jju_lnx.backbone.dif.dk>
	 <Pine.LNX.4.56.0312222016530.27724@jju_lnx.backbone.dif.dk>
Content-Type: text/plain
Message-Id: <1072141605.2947.18.camel@duergar>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Mon, 22 Dec 2003 20:06:47 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-12-22 at 14:18, Jesper Juhl wrote:
> Forgot to include the "Badness in pci_find_subsys" bits of the log - here
> you are.
> Original message below.

Have you tried reporting this to the minion guy(s)?  I'm sure if its in
the open source part of the driver it can be fixed by them.  It's in all
of our interest (especially us nvidia users *sigh*) to report these
problems to people who can fix them.

Thanks,

sb

