Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932658AbWJFWw7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932658AbWJFWw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Oct 2006 18:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932659AbWJFWw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Oct 2006 18:52:59 -0400
Received: from mcr-smtp-002.bulldogdsl.com ([212.158.248.8]:4360 "EHLO
	mcr-smtp-002.bulldogdsl.com") by vger.kernel.org with ESMTP
	id S932658AbWJFWw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Oct 2006 18:52:58 -0400
X-Spam-Abuse: Please report all spam/abuse matters to abuse@bulldogdsl.com
From: Alistair John Strachan <s0348365@sms.ed.ac.uk>
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: ohci1394 regression in 2.6.19-rc1
Date: Fri, 6 Oct 2006 23:52:54 +0100
User-Agent: KMail/1.9.4
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       bcollins@debian.org, linux1394-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org> <45268FB1.6080605@s5r6.in-berlin.de> <tkrat.9af0ae80a84cddfa@s5r6.in-berlin.de>
In-Reply-To: <tkrat.9af0ae80a84cddfa@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610062352.54501.s0348365@sms.ed.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 06 October 2006 19:33, Stefan Richter wrote:
> Alistair, could you please test the following one-liner on top of
> 2.6.19-rc1?

Thanks Stefan, this fixes everything.

I'm puzzled and annoyed that I wasn't able to observe the same behaviour you 
were with the mentioned patches reverted, I'm certain I did it correctly.. 
just as well you tried it.

-- 
Cheers,
Alistair.

Final year Computer Science undergraduate.
1F2 55 South Clerk Street, Edinburgh, UK.
