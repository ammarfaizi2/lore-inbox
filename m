Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136174AbRD0TM7>; Fri, 27 Apr 2001 15:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136178AbRD0TMk>; Fri, 27 Apr 2001 15:12:40 -0400
Received: from ns2.cypress.com ([157.95.67.5]:13773 "EHLO ns2.cypress.com")
	by vger.kernel.org with ESMTP id <S136175AbRD0TM3>;
	Fri, 27 Apr 2001 15:12:29 -0400
Message-ID: <3AE9C48E.2F617997@cypress.com>
Date: Fri, 27 Apr 2001 14:12:14 -0500
From: Thomas Dodd <ted@cypress.com>
Organization: Cypress Semiconductor Southeast Design Center
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en-US, en-GB, en, de-DE, de-AT, de-CH, de, zh-TW, zh-CN, zh
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: binfmt_misc on 2.4.3-ac14
In-Reply-To: <86256A3A.007A6C40.00@smtpnotes.altec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Wayne.Brown@altec.com wrote:
> 
> <marpet@buy.pl> wrote:
> >is it going to become the default in future kernel releases?
> It's been that way in the -ac kernels for a while now, but Linus hasn't put it
> into his kernels yet.  Perhaps he's waiting until work begins on 2.5, rather
> than break an existing interface in 2.4.  Anyway, it's entirely up to Linus, so
> I'm just guessing here. :-)

It's in the 2.4 kernels from RedHat (like the one shipped with SeaWolf)
So if you update you distro you'll see it for a while.

I thought the plan was to move this out of /proc and
to say /etc where config info like this "belongs".
Did this change?

	-Thomas
