Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262279AbUFWXRo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262279AbUFWXRo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Jun 2004 19:17:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262213AbUFWXRo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Jun 2004 19:17:44 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:55441 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262175AbUFWXRf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Jun 2004 19:17:35 -0400
Message-ID: <40DA0F7D.60606@pobox.com>
Date: Wed, 23 Jun 2004 19:17:17 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mariusz Mazur <mmazur@kernel.pl>
CC: linux-kernel@vger.kernel.org
Subject: Re: [ANNOUNCE] linux-libc-headers 2.6.7.0
References: <200406240020.39735.mmazur@kernel.pl>
In-Reply-To: <200406240020.39735.mmazur@kernel.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mariusz Mazur wrote:
> Available at http://ep09.pld-linux.org/~mmazur/linux-libc-headers/
> Changes:
> - updated to 2.6.7
> - some minor fixes
> 
> Enjoy.
> 
> 
> Llh is all good and nice, cause it works (most of the times anyway), but with 
> every new release the possibility of desync from kernel increases - downfalls 
> of maintaining it as a separate package. Could anybody point me to some 
> conclusions about how the thing should be done The Right Way (preferably with 
> some input from high profile kernel hackers, so I can have some assurance 
> that once something gets done it will get merged)?


HPA suggested include/abi and I don't think anyone objected.

But that's most likely a 2.7 project :(

	Jeff


