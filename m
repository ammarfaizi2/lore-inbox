Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262033AbTLNOkt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Dec 2003 09:40:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262051AbTLNOkt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Dec 2003 09:40:49 -0500
Received: from mailhost.tue.nl ([131.155.2.7]:60690 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262033AbTLNOks (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Dec 2003 09:40:48 -0500
Date: Sun, 14 Dec 2003 15:40:46 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Wakko Warner <wakko@animx.eu.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 and IDE "geometry"
Message-ID: <20031214144046.GA11870@win.tue.nl>
References: <20031212131704.A26577@animx.eu.org> <20031212194439.GB11215@win.tue.nl> <20031212163545.A26866@animx.eu.org> <20031213132208.GA11523@win.tue.nl> <20031213171800.A28547@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031213171800.A28547@animx.eu.org>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 13, 2003 at 05:18:00PM -0500, Wakko Warner wrote:

> The script does use sfdisk to aquire the size and the user tells it just how
> large the partition to be and defaulting to the largest possible.  If the
> geometry is wrong, the other OS won't boot.

What interests me is: do you need varying geometry?
That is: do you sometimes need */16/63 and sometimes */255/63
or even other values?

Or does it suffice to take */255/63 always?



