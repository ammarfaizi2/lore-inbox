Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbTJSULp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Oct 2003 16:11:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262181AbTJSULp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Oct 2003 16:11:45 -0400
Received: from holomorphy.com ([66.224.33.161]:43138 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262183AbTJSULo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Oct 2003 16:11:44 -0400
Date: Sun, 19 Oct 2003 13:11:17 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Hans Reiser <reiser@namesys.com>, Larry McVoy <lm@bitmover.com>,
       Norman Diamond <ndiamond@wta.att.ne.jp>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
       nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
       Justin Cormack <justin@street-vision.com>,
       Russell King <rmk+lkml@arm.linux.org.uk>,
       Vitaly Fertman <vitaly@namesys.com>, Krzysztof Halasa <khc@pm.waw.pl>,
       axboe@suse.de
Subject: Re: Blockbusting news, results are in
Message-ID: <20031019201117.GB1215@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Pavel Machek <pavel@suse.cz>, Hans Reiser <reiser@namesys.com>,
	Larry McVoy <lm@bitmover.com>,
	Norman Diamond <ndiamond@wta.att.ne.jp>,
	Wes Janzen <superchkn@sbcglobal.net>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	John Bradford <john@grabjohn.com>, linux-kernel@vger.kernel.org,
	nikita@namesys.com, Pavel Machek <pavel@ucw.cz>,
	Justin Cormack <justin@street-vision.com>,
	Russell King <rmk+lkml@arm.linux.org.uk>,
	Vitaly Fertman <vitaly@namesys.com>,
	Krzysztof Halasa <khc@pm.waw.pl>, axboe@suse.de
References: <1c6401c395e7$16630d00$3eee4ca5@DIAMONDLX60> <20031019041553.GA25372@work.bitmover.com> <3F924660.4040405@namesys.com> <20031019083551.GA1108@holomorphy.com> <20031019200105.GD354@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031019200105.GD354@elf.ucw.cz>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> I think the fs driver layer might be the wrong thing too; maybe it'd be
>> best to do the CRC and/or checksumming at the block layer?

On Sun, Oct 19, 2003 at 10:01:05PM +0200, Pavel Machek wrote:
> I think that's best place.
> Here's first attempt at implementation:
> http://www.ussg.iu.edu/hypermail/linux/kernel/0004.3/0487.html

Wow, that was a while ago. Well, I'm impressed.


-- wli
