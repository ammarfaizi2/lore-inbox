Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263522AbTK1Vr5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:47:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263523AbTK1Vr5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:47:57 -0500
Received: from adsl-216-102-91-59.dsl.snfc21.pacbell.net ([216.102.91.59]:43963
	"EHLO nasledov.com") by vger.kernel.org with ESMTP id S263522AbTK1Vr4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:47:56 -0500
Date: Fri, 28 Nov 2003 13:50:08 -0800
To: William Lee Irwin III <wli@holomorphy.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
Message-ID: <20031128215008.GA2541@nasledov.com>
References: <20031127062057.GA31974@nasledov.com> <20031128212853.GB8039@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031128212853.GB8039@holomorphy.com>
User-Agent: Mutt/1.5.4i
From: Misha Nasledov <misha@nasledov.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It would be really annoying if my laptop suspended when I closed the lid; I
disabled this feature in the BIOS. I will test if it suspends with this feature
enabled, but it doesn't change the fact that there is something broken with
APM. Running 'apm --suspend' doesn't work either.

On Fri, Nov 28, 2003 at 01:28:53PM -0800, William Lee Irwin III wrote:
> On Wed, Nov 26, 2003 at 10:20:57PM -0800, Misha Nasledov wrote:
> > Since about 2.6.0-test9, my ThinkPad T21 no longer suspends with APM. I had
> > issues with it suspending before, I don't remember exactly what issues, but I
> > know that it definitely worked in -test2. When I hit the key on my laptop to
> > suspend, it will turn off the LCD and the HD will spin down, but the machine
> > will not actually suspend. Here is what is printed out on the console when I
> > hit the suspend key and then when I hit another key to "wake" it up:
> 
> Mine suspends okay when I close the lid, but it's never honored the
> button that I know of (or button-based suspend broke too often for me
> to notice it ever working).

-- 
Misha Nasledov
misha@nasledov.com
http://nasledov.com/misha/
