Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263423AbTJQNET (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Oct 2003 09:04:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263453AbTJQNET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Oct 2003 09:04:19 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:8723 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S263423AbTJQNEH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Oct 2003 09:04:07 -0400
Date: Fri, 17 Oct 2003 14:03:54 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: John Bradford <john@grabjohn.com>
Cc: Norman Diamond <ndiamond@wta.att.ne.jp>, Hans Reiser <reiser@namesys.com>,
       Wes Janzen <superchkn@sbcglobal.net>,
       Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
Subject: Re: Blockbusting news, this is important (Re: Why are bad disk sectors numbered strangely, and what happens to them?)
Message-ID: <20031017140354.A2415@flint.arm.linux.org.uk>
Mail-Followup-To: John Bradford <john@grabjohn.com>,
	Norman Diamond <ndiamond@wta.att.ne.jp>,
	Hans Reiser <reiser@namesys.com>,
	Wes Janzen <superchkn@sbcglobal.net>,
	Rogier Wolff <R.E.Wolff@BitWizard.nl>, linux-kernel@vger.kernel.org
References: <32a101c3916c$e282e330$5cee4ca5@DIAMONDLX60> <200310131014.h9DAEwY3000241@81-2-122-30.bradfords.org.uk> <33a201c39174$2b936660$5cee4ca5@DIAMONDLX60> <20031014064925.GA12342@bitwizard.nl> <3F8BA037.9000705@sbcglobal.net> <3F8BBC08.6030901@namesys.com> <11bf01c39492$bc5307c0$3eee4ca5@DIAMONDLX60> <3F8FBADE.7020107@namesys.com> <126d01c3949f$91bdecc0$3eee4ca5@DIAMONDLX60> <200310171253.h9HCr1tw000933@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200310171253.h9HCr1tw000933@81-2-122-30.bradfords.org.uk>; from john@grabjohn.com on Fri, Oct 17, 2003 at 01:53:01PM +0100
X-Message-Flag: Your copy of Microsoft Outlook is vulnerable to viruses. See www.mutt.org for more details.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 17, 2003 at 01:53:01PM +0100, John Bradford wrote:
> I disagree - we haven't confirmed what happens in the error-on-write
> situation.  If it does indeed always remap the block, then I'd agree
> that that aspect was perfectly sane.

My comments were based upon the information contained within the mail
which appeared to originate from the manufacturer.

Plus, they were in *PRIVATE*.  Sheesh.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
