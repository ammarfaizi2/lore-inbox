Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267475AbUIPEqP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267475AbUIPEqP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 00:46:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267460AbUIPEqP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 00:46:15 -0400
Received: from launch.server101.com ([216.218.196.178]:21634 "EHLO
	mail-pop3-1.server101.com") by vger.kernel.org with ESMTP
	id S267494AbUIPEqG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 00:46:06 -0400
From: Tim Fairchild <tim@bcs4me.com>
To: =?iso-8859-1?q?Rog=E9rio_Brito?= <rbrito@ime.usp.br>
Subject: Re: [OOPS] Oops with kernel 2.6.9-rc2
Date: Thu, 16 Sep 2004 14:45:50 +1000
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040915160143.GA4874@ime.usp.br> <20040915162126.2899b2f7.akpm@osdl.org> <FF22C612-0782-11D9-8789-0003931DD2FA@ime.usp.br>
In-Reply-To: <FF22C612-0782-11D9-8789-0003931DD2FA@ime.usp.br>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200409161445.50799.tim@bcs4me.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 Sep 2004 11:51, Rogério Brito wrote:
> On 15 de set de 2004, at 20:21, Andrew Morton wrote:

> > Were you using a cdrom at that time?   If so, this will probably fix
> > it:
>
> Yes, I think that I was. Today I got another amount of Oopsen. I will
> try the patch right now and report back my results.

I've been using 2.6.9-rc2 with the patch and it's working well - no oops with 
cdrom use now. 

tim
