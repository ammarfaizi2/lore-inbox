Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263609AbUAIU5r (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jan 2004 15:57:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263851AbUAIU5q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jan 2004 15:57:46 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:33547 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263609AbUAIU5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jan 2004 15:57:14 -0500
Date: Fri, 9 Jan 2004 20:57:12 +0000 (GMT)
From: James Simmons <jsimmons@infradead.org>
To: S Ait-Kassi <sait-kassi@zonnet.nl>
cc: linux-kernel@vger.kernel.org
Subject: Re: [update]  Vesafb problem since 2.5.51
In-Reply-To: <200401080040.25061.sait-kassi@zonnet.nl>
Message-ID: <Pine.LNX.4.44.0401092055430.27985-100000@phoenix.infradead.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


That is a normal config. I have the same thing. Try my latest patch. I did 
a up data again. This time the patch is against 2.6.0-rc3. 

P.S
   Have tried the Radeon fbdev driver ?
 

On Thu, 8 Jan 2004, S Ait-Kassi wrote:

> > > fb-con modular?). Three of the four people who stated they had this
> > > problem had a ATI card (two had a Radeon 7500 and I have a Radeon 9500
> > > and one didn't include the videocard). :(
> >
> > What is your config?
> 
> That is my kernel config? I attached it to this mail.
 

