Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261899AbULKIvw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261899AbULKIvw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Dec 2004 03:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261901AbULKIvw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Dec 2004 03:51:52 -0500
Received: from b.relay.invitel.net ([62.77.203.4]:38377 "EHLO
	b.relay.invitel.net") by vger.kernel.org with ESMTP id S261899AbULKIvu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Dec 2004 03:51:50 -0500
Date: Sat, 11 Dec 2004 09:52:14 +0100
From: =?iso-8859-2?B?R+Fib3IgTOlu4XJ0?= <lgb@lgb.hu>
To: Imanpreet Singh Arora <imanpreet@gmail.com>
Cc: lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: What if?
Message-ID: <20041211085214.GB32015@vega>
Reply-To: lgb@lgb.hu
References: <41AE5BF8.3040100@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <41AE5BF8.3040100@gmail.com>
X-Operating-System: vega Linux 2.6.9 i686
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2004 at 05:34:08AM +0530, Imanpreet Singh Arora wrote:
> familiar with C, rather than C++. However other than that what are the  
> _implementation_  issues that you hackers might need to consider if it 
> were to be implemented in C++. My question is regarding how will kernel 

It's a quite simple question: why would it better to implement kernel
in C++? To CHANGE something, you should always consider the advantages
and disadvantages. I think it's NO advantages to implement kernel in C++
over to do it in C. So then why is it useful?

- Gábor (larta'H)
