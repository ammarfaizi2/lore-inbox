Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263491AbTK1V3R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:29:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbTK1V3R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:29:17 -0500
Received: from holomorphy.com ([199.26.172.102]:1988 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263491AbTK1V3C (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:29:02 -0500
Date: Fri, 28 Nov 2003 13:28:53 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Misha Nasledov <misha@nasledov.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: APM Suspend Problem
Message-ID: <20031128212853.GB8039@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Misha Nasledov <misha@nasledov.com>, linux-kernel@vger.kernel.org
References: <20031127062057.GA31974@nasledov.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031127062057.GA31974@nasledov.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 26, 2003 at 10:20:57PM -0800, Misha Nasledov wrote:
> Since about 2.6.0-test9, my ThinkPad T21 no longer suspends with APM. I had
> issues with it suspending before, I don't remember exactly what issues, but I
> know that it definitely worked in -test2. When I hit the key on my laptop to
> suspend, it will turn off the LCD and the HD will spin down, but the machine
> will not actually suspend. Here is what is printed out on the console when I
> hit the suspend key and then when I hit another key to "wake" it up:

Mine suspends okay when I close the lid, but it's never honored the
button that I know of (or button-based suspend broke too often for me
to notice it ever working).


-- wli
