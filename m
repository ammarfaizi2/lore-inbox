Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132558AbREHOPq>; Tue, 8 May 2001 10:15:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132561AbREHOPf>; Tue, 8 May 2001 10:15:35 -0400
Received: from 13dyn127.delft.casema.net ([212.64.76.127]:40976 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S132558AbREHOPX>; Tue, 8 May 2001 10:15:23 -0400
Message-Id: <200105081415.QAA00401@cave.bitwizard.nl>
Subject: Re: CML2 design philosophy heads-up
In-Reply-To: <20010508031511.A15782@thyrsus.com> from "Eric S. Raymond" at "May
 8, 2001 03:15:11 am"
To: "Eric S. Raymond" <esr@thyrsus.com>
Date: Tue, 8 May 2001 16:15:08 +0200 (MEST)
CC: Jamie Lokier <lk@tantalophile.demon.co.uk>,
        Tom Rini <trini@kernel.crashing.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>,
        CML2 <linux-kernel@vger.kernel.org>,
        kbuild-devel@lists.sourceforge.net
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric S. Raymond wrote:
> More generally, arguments of the form "Non-mainline custom hack X
> could invalidate constraint Y, therefore we can't have Y in the
> rulebase" are dangerous -- I suspect you could reduce your set of
> constraints to nil very quickly that way, and thus badly screw over
> the 99% of people who just want to build a more or less stock kernel.

Eric, 

Still being able to use the "tool" is useful! So I want a "don't mess
with me" mode where I'd get more control than 99% of the lusers....

			Roger. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
