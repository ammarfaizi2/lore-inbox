Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265191AbTLRO1O (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 09:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265193AbTLRO1N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 09:27:13 -0500
Received: from intra.cyclades.com ([64.186.161.6]:1187 "EHLO
	intra.cyclades.com") by vger.kernel.org with ESMTP id S265191AbTLRO1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 09:27:07 -0500
Date: Thu, 18 Dec 2003 12:11:53 -0200 (BRST)
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
X-X-Sender: marcelo@logos.cnet
To: Frank van Maarseveen <frankvm@xs4all.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.23 Oops in journal_try_to_free_buffers (fwd)
In-Reply-To: <20031218131659.GA28450@iapetus.localdomain>
Message-ID: <Pine.LNX.4.44.0312181209540.14081-100000@logos.cnet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Cyclades-MailScanner-Information: Please contact the ISP for more information
X-Cyclades-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Have you tried the memtest86? 

I really dont see any suspicious change which could cause it from .22 to 
23. Ill keep looking though.

Stephen Tweedie suggested it might be a memory corruption, but it seems 
you already tried the memtest86 yes?

