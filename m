Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262453AbVE0MYv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262453AbVE0MYv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 08:24:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262447AbVE0MYV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 08:24:21 -0400
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:10501 "EHLO
	pollux.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S262444AbVE0MYS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 08:24:18 -0400
Date: Fri, 27 May 2005 13:24:23 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Denis Vlasenko <vda@ilport.com.ua>
Cc: cutaway@bellsouth.net, linux-kernel@vger.kernel.org
Subject: Re: 387 emulator hack - mutant AAD trick - any objections?
In-Reply-To: <200505271235.41353.vda@ilport.com.ua>
Message-ID: <Pine.LNX.4.61L.0505271318580.14679@blysk.ds.pg.gda.pl>
References: <007001c56290$25dd4d00$2800000a@pc365dualp2>
 <200505271235.41353.vda@ilport.com.ua>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Denis Vlasenko wrote:

> No need to use AAD16, it is 
> a) doesnt work on some obscure ancient NEC x86 clones IIRC

 Who cares about 16-bit silicon?

> b) is microcoded (slow)

 But certainly not worse than the alternatives for these processors which 
actually lack the x87 subset.

  Maciej
