Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281910AbRLQSiI>; Mon, 17 Dec 2001 13:38:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282056AbRLQSh6>; Mon, 17 Dec 2001 13:37:58 -0500
Received: from dsl254-075-066.nyc1.dsl.speakeasy.net ([216.254.75.66]:20484
	"EHLO free.transpect.com") by vger.kernel.org with ESMTP
	id <S281932AbRLQShl>; Mon, 17 Dec 2001 13:37:41 -0500
Date: Mon, 17 Dec 2001 13:34:33 -0500
From: Whit Blauvelt <whit@transpect.com>
To: J Sloan <jjs@pobox.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops - 2.4.17rc1 
Message-ID: <20011217133433.C2116@free.transpect.com>
In-Reply-To: <20011215005641.A810@china.patternbook.com> <3C1AEFB7.119D8902@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3C1AEFB7.119D8902@pobox.com>; from jjs@pobox.com on Fri, Dec 14, 2001 at 10:37:43PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 14, 2001 at 10:37:43PM -0800, J Sloan wrote:

> iptables is already in the kernel, so an iptables
> patch does sound experimental, e.g. you are
> adding something new -
> 
> BTW 2.4.6 doesn't sound right for an iptables
> version -

Right! Got to stop typing late at night. Presumably iptables 1.2.4 make does
not add anything new to the kernel, but just builds the utilities agains it?
In anycase, nothing experimental was specified. Or is the kernel including
previous iptables code?

Whit
