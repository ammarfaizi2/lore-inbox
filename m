Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262658AbVGHNka@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262658AbVGHNka (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:40:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262659AbVGHNka
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:40:30 -0400
Received: from [203.171.93.254] ([203.171.93.254]:48535 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262658AbVGHNk2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:40:28 -0400
Subject: Re: Suspend2 2.1.9.8 for 2.6.12: 622-swapwriter.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Cc: Nigel Cunningham <nigel@suspend2.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <courier.42CD288A.00003A98@courier.cs.helsinki.fi>
References: <11206164393426@foobar.com> <11206164442712@foobar.com>
	 <84144f0205070523332cc6d487@mail.gmail.com>
	 <1120740053.4860.1494.camel@localhost>
	 <courier.42CD288A.00003A98@courier.cs.helsinki.fi>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120830109.4860.3029.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 08 Jul 2005 23:41:50 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Thu, 2005-07-07 at 23:05, Pekka J Enberg wrote:
> Hi Nigel, 
> 
> On Wed, 2005-07-06 at 16:33, Pekka Enberg wrote:
> > > You're hardcoding sector size here, no?
> 
> Nigel Cunningham writes:
> > As others do.
> 
> Even so, please use a constant. 

Done
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

