Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269084AbTGUAN1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Jul 2003 20:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269085AbTGUAN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Jul 2003 20:13:27 -0400
Received: from blackbird.intercode.com.au ([203.32.101.10]:53005 "EHLO
	blackbird.intercode.com.au") by vger.kernel.org with ESMTP
	id S269084AbTGUAN0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Jul 2003 20:13:26 -0400
Date: Mon, 21 Jul 2003 10:28:09 +1000 (EST)
From: James Morris <jmorris@intercode.com.au>
To: Sean Neakums <sneakums@zork.net>
cc: netdev@oss.sgi.com, <linux-kernel@vger.kernel.org>
Subject: Re: [2.6.0-test1-mm1] TCP connections over ipsec hang after a few
 seconds
In-Reply-To: <6uwued6lzv.fsf@zork.zork.net>
Message-ID: <Mutt.LNX.4.44.0307211026210.25753-100000@excalibur.intercode.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 20 Jul 2003, Sean Neakums wrote:

> > With the 100baseT configuration, are the systems on the same segment?
> 
> I'm connecting the two machines with a crossed-over cable.

I can't see anything strange here.  Can you confirm that you are seeing 
the pmtu messages for the crossover cable case?  If not, perhaps try 
manual configuration to rule out any racoon issues.


- James
-- 
James Morris
<jmorris@intercode.com.au>

