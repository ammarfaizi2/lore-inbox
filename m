Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262280AbVGFQM7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262280AbVGFQM7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 12:12:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262244AbVGFQM6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 12:12:58 -0400
Received: from [203.171.93.254] ([203.171.93.254]:19940 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262319AbVGFL52 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Jul 2005 07:57:28 -0400
Subject: Re: [PATCH] [26/48] Suspend2 2.1.9.8 for 2.6.12:
	603-suspend2_common-headers.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@cs.helsinki.fi>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <84144f0205070603223790e4df@mail.gmail.com>
References: <11206164393426@foobar.com> <11206164424053@foobar.com>
	 <84144f0205070603223790e4df@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120651125.4860.233.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 06 Jul 2005 21:58:45 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again.

On Wed, 2005-07-06 at 20:22, Pekka Enberg wrote:
> > + * suspend_snprintf
> > + *
> > + * Functionality    : Print a string with parameters to a buffer of a
> > + *                    limited size. Unlike vsnprintf, we return the number
> > + *                    of bytes actually put in the buffer, not the number
> > + *                    that would have been put in if it was big enough.
> > + */
> Please do move these.

Renamed and merged into lib/vsprintf.c.

Regards,

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

