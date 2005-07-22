Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262013AbVGVCiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262013AbVGVCiW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Jul 2005 22:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262014AbVGVCiW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Jul 2005 22:38:22 -0400
Received: from r3az252.chello.upc.cz ([213.220.243.252]:31916 "EHLO
	aquarius.doma") by vger.kernel.org with ESMTP id S262013AbVGVCiV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Jul 2005 22:38:21 -0400
Message-ID: <42E05C17.2000305@ribosome.natur.cuni.cz>
Date: Fri, 22 Jul 2005 04:38:15 +0200
From: =?windows-1252?Q?Martin_MOKREJ=8A?= 
	<mmokrejs@ribosome.natur.cuni.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050511
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Mark Nipper <nipsy@bitgnome.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Giving developers clue how many testers verified certain kernel
 version
References: <42E04D11.20005@ribosome.natur.cuni.cz> <20050722021046.GB21727@king.bitgnome.net>
In-Reply-To: <20050722021046.GB21727@king.bitgnome.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Mark Nipper wrote:
> 	I have a different idea along these lines but not using
> bugzilla.  A nice system for tracking usage of certain components
> might be made by having people register using a certain e-mail
> address and then submitting their .config as they try out new
> versions of kernels.

Nice idea, but I still think it is of interrest on what hardware
was it tested. Maybe also 'dmesg' output would help a bit, but
I still don't know how you'd find that I have _this_ motherboard
instead of another.

Second, I'd submit sometimes 2 or even 3 tested hosts. But am
willing to use only single email, though. ;)

I think we'd need some sort of profile, the profile would contain
some HW info, like motherboard type, bios version etc. To extract
that from 'dmesg' would be a nightmare I think.

...

> 	Just an idea.  It might require some minimum
> recommendations to users willing to participate.  I know for
> example that I statically compile all four I/O schedulers in all

Well, my case too. ;)

Martin
