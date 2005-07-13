Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262626AbVGMKzL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262626AbVGMKzL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 06:55:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbVGMKxF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 06:53:05 -0400
Received: from web32003.mail.mud.yahoo.com ([68.142.207.100]:24926 "HELO
	web32003.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S262626AbVGMKvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 06:51:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NlH0xF723maAYYkunbedsjCkeYCk/d2iHdpvVL85oUZCtJCWbXYz6r6CTvgH4v0aOYqw6pOWDzwclmXZr9fg8Iv51te5DUZOWqPK7Q4UkEAXx/PTlZczo8yyzbDLZ+B8jcwt2nmK8byg/Op8DZGRtnFreP4EGzlB87p0KrM6+5k=  ;
Message-ID: <20050713105127.59527.qmail@web32003.mail.mud.yahoo.com>
Date: Wed, 13 Jul 2005 03:51:26 -0700 (PDT)
From: Sam Song <samlinuxkernel@yahoo.com>
Subject: Re: [patch 2.6.13-git] 8250 tweaks
To: Russell King <rmk+lkml@arm.linux.org.uk>
Cc: david-b@pacbell.net, linux-kernel@vger.kernel.org
In-Reply-To: <20050713071245.B19871@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King <rmk+lkml@arm.linux.org.uk> wrote:
> However, if you merely lifted the later 8250.c and
> put it into a previous kernel (which looks like the 
> case), there's other changes in addition which are 
> required.

Good catch. I tried 2.6.13-rc1 and the newest version
2.6.13-rc3 on the same target[MPC8241]. The whining 
remained the same. 

Thanks,

Sam


		
__________________________________ 
Do you Yahoo!? 
Yahoo! Mail - Find what you need with new enhanced search. 
http://info.mail.yahoo.com/mail_250
