Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUFYLe5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUFYLe5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 07:34:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266709AbUFYLe5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 07:34:57 -0400
Received: from dsl092-053-140.phl1.dsl.speakeasy.net ([66.92.53.140]:23691
	"EHLO grelber.thyrsus.com") by vger.kernel.org with ESMTP
	id S266357AbUFYLez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 07:34:55 -0400
From: Rob Landley <rob@landley.net>
To: Mariusz Mazur <mmazur@kernel.pl>, linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
Date: Fri, 25 Jun 2004 06:33:28 -0500
User-Agent: KMail/1.5.4
References: <200406240020.39735.mmazur@kernel.pl>
In-Reply-To: <200406240020.39735.mmazur@kernel.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200406250633.28530.rob@landley.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 23 June 2004 17:20, Mariusz Mazur wrote:
> Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
> Changes:
> - updated to 2.6.7
> - some minor fixes
>
> Enjoy.
>
>
> Llh is all good and nice, cause it works (most of the times anyway), but
> with every new release the possibility of desync from kernel increases -
> downfalls of maintaining it as a separate package. Could anybody point me
> to some conclusions about how the thing should be done The Right Way
> (preferably with some input from high profile kernel hackers, so I can have
> some assurance that once something gets done it will get merged)?

Follow the thread:

http://seclists.org/lists/linux-kernel/2004/Jun/4713.html

Randy Dunlap mentioned a linux abi mailing list.  I subscribed a few days ago, 
but no traffic's come across it yet...

http://zytor.com/mailman/listinfo/linuxabi

Rob
-- 
www.linucon.org: Linux Expo and Science Fiction Convention
October 8-10, 2004 in Austin Texas.  (I'm the con chair.)

