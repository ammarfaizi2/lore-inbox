Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261312AbVGGMZI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261312AbVGGMZI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 08:25:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261385AbVGGMXe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 08:23:34 -0400
Received: from [203.171.93.254] ([203.171.93.254]:22916 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S261284AbVGGMSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 08:18:15 -0400
Subject: Re: [0/48] Suspend2 2.1.9.8 for 2.6.12
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka Enberg <penberg@gmail.com>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <84144f02050705234074ff7b99@mail.gmail.com>
References: <nigel@suspend2.net> <11206164393426@foobar.com>
	 <84144f02050705234074ff7b99@mail.gmail.com>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120738774.4860.1443.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 07 Jul 2005 22:19:34 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2005-07-06 at 16:40, Pekka Enberg wrote:
> Hi Nigel,
> 
> On 7/6/05, Nigel Cunningham <nigel@suspend2.net> wrote:
> > As requested, here are the patches that form Suspend2, for review.
> > 
> > I've tried to split it up into byte size chunks, but please don't expect
> > that these will be patches that can mutate swsusp into Suspend2. That
> > would roughly equivalent to asking for patches that patch Reiser3 into
> > Reiser4 - it's a redesign.
> 
> Please consider putting diffstat in the patches. They make navigating
> large patchsets easier.

Adjusted my patch generation script to do this.

Thanks.

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

