Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272265AbTHDWGH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 18:06:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272266AbTHDWGH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 18:06:07 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:13719
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S272265AbTHDWGD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 18:06:03 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] O13int for interactivity
Date: Tue, 5 Aug 2003 08:11:09 +1000
User-Agent: KMail/1.5.3
Cc: linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
References: <5.2.1.1.2.20030804213330.0196e2d0@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030804213330.0196e2d0@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308050811.09590.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Aug 2003 06:11, Mike Galbraith wrote:

> IMHO, absolute cut off is a very bad idea (btdt, and it _sucked rocks_).
>
> The last thing in the world you want to do is to remove differentiation
> between tasks... try to classify them and make them all the same within
> their class.  For grins, take away all remaining differentiation, and run a
> hefty parallel make.

I didn't fully understand you but I get your drift. I have a better solution 
in the works anyway but I wanted this tested.

Con

