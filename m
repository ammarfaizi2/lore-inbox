Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262622AbTIAG5b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 02:57:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262652AbTIAG5b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 02:57:31 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:4614 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S262622AbTIAG5a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 02:57:30 -0400
Date: Mon, 1 Sep 2003 07:57:26 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>,
       kernel list <linux-kernel@vger.kernel.org>,
       Patrick Mochel <mochel@osdl.org>
Subject: Re: Fix up power managment in 2.6
Message-ID: <20030901075726.A12457@flint.arm.linux.org.uk>
Mail-Followup-To: Pavel Machek <pavel@ucw.cz>,
	Linus Torvalds <torvalds@osdl.org>,
	kernel list <linux-kernel@vger.kernel.org>,
	Patrick Mochel <mochel@osdl.org>
References: <20030831232812.GA129@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030831232812.GA129@elf.ucw.cz>; from pavel@ucw.cz on Mon, Sep 01, 2003 at 01:28:12AM +0200
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 01, 2003 at 01:28:12AM +0200, Pavel Machek wrote:
> Please take attached patch, and apply with -R, to bring tree back to
> -test3 state. It should be a non-brainer, as Patrick's patch should
> not go in in the first place. [If you can do some bk magic to exclude
> Patrick's power managment merge, that would be even better].

Please don't.  A number of us are working _with_ Patrick to sort the
problems out and get them resolved.  IMHO, there are good changes in
Pat's work, and backing the lot out would be silly at this point.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

