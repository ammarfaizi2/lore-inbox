Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267841AbUIPIbP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267841AbUIPIbP (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Sep 2004 04:31:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267851AbUIPIbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Sep 2004 04:31:15 -0400
Received: from smtpout1.uol.com.br ([200.221.11.54]:29553 "EHLO
	smtp.uol.com.br") by vger.kernel.org with ESMTP id S267841AbUIPIbM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Sep 2004 04:31:12 -0400
Date: Thu, 16 Sep 2004 05:30:33 -0300
From: =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
To: Tim Fairchild <tim@bcs4me.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [OOPS] Oops with kernel 2.6.9-rc2
Message-ID: <20040916083033.GA21321@ime.usp.br>
Mail-Followup-To: Tim Fairchild <tim@bcs4me.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <20040915160143.GA4874@ime.usp.br> <20040915162126.2899b2f7.akpm@osdl.org> <FF22C612-0782-11D9-8789-0003931DD2FA@ime.usp.br> <200409161445.50799.tim@bcs4me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200409161445.50799.tim@bcs4me.com>
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 16 2004, Tim Fairchild wrote:
> On Thursday 16 Sep 2004 11:51, Rogério Brito wrote:
> > Yes, I think that I was. Today I got another amount of Oopsen. I will
> > try the patch right now and report back my results.
> 
> I've been using 2.6.9-rc2 with the patch and it's working well - no oops with 
> cdrom use now. 

Just as a feedback that I promised, it's working correctly now with the
patch applied. It seems that the problem was indeed caused by accessing
CDs.


Thanks, Rogério.

-- 
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
  Rogério Brito - rbrito@ime.usp.br - http://www.ime.usp.br/~rbrito
=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
