Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264447AbRGEVyo>; Thu, 5 Jul 2001 17:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264463AbRGEVyd>; Thu, 5 Jul 2001 17:54:33 -0400
Received: from cs.columbia.edu ([128.59.16.20]:12993 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S264447AbRGEVyV>;
	Thu, 5 Jul 2001 17:54:21 -0400
Message-Id: <200107052154.RAA07008@razor.cs.columbia.edu>
X-Mailer: exmh version 2.1.1 10/15/1999
To: Davide Libenzi <davidel@xmailserver.org>
cc: David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ... 
In-Reply-To: Your message of "Thu, 05 Jul 2001 14:45:21 PDT."
             <XFMail.20010705144521.davidel@xmailserver.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Jul 2001 17:54:17 -0400
From: Hua Zhong <huaz@cs.columbia.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Doesn't it add more overhead?  I think using inline functions are much better. 
 Yes you have to define it for different types (char, short, int, long, 
signed/unsigned).

> Yep, it's better.
> 
> 
> - Davide


