Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291851AbSBHVQi>; Fri, 8 Feb 2002 16:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291842AbSBHVPC>; Fri, 8 Feb 2002 16:15:02 -0500
Received: from 92dyn231.com21.casema.net ([62.234.23.231]:40357 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S291837AbSBHVOQ>; Fri, 8 Feb 2002 16:14:16 -0500
Message-Id: <200202082114.WAA13937@cave.bitwizard.nl>
Subject: Re: [PATCH] Specialix RIO Oops fix
In-Reply-To: <20020204090200.A30872@osiris.silug.org> from Steven Pritchard at
 "Feb 4, 2002 09:02:00 am"
To: Steven Pritchard <steve@silug.org>
Date: Fri, 8 Feb 2002 22:14:11 +0100 (MET)
CC: linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Pritchard wrote:
> The patch below fixes an Oops in the Specialix RIO driver.  I sent
> this to the maintainer a couple of months ago and never got a
> response.

Hi Steve, 

I'm the maintainer, and I just found your 15-11-2001 mail. Indeed I
seem to have forgotten to reply.. Sorry about that.

We have fixed a couple of RIO things since 2.4.2, so I would recommend
that you try running a more recent kernel....

And keep bugging me and/or perle/specialix support if you need
help. This card/driver is supported and you should get the support you
require. We'll work with you till it works. (but we do reserve the
right to ask you to upgrade to a kernel that has fixes we've done in
the past...)

			Rogier. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
