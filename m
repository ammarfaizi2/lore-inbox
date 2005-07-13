Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVGMWPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVGMWPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 18:15:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262224AbVGMWMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 18:12:13 -0400
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32]:54394 "HELO
	smtp001.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262300AbVGMWJ7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 18:09:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=b2wGLQQk4Mr1FAVkp9NzS9vVfFkfdBC55bF1dyvpfko5rlx8uxZQcp1x6tvHOGKmjzWclibJdaGTM6yYr7X2e6YIiP5HaxRjO3c0yTlB06MI+I5gqrz0pNj2U/ImqtKRr4VTUvwTZYgqelyLLpIxfUhKgFdJ3zcXkWY4kgTRI1k=  ;
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 1/9] uml: fix lvalue for gcc4
Date: Thu, 14 Jul 2005 00:17:28 +0200
User-Agent: KMail/1.8.1
Cc: Andrew Morton <akpm@osdl.org>, jdike@addtoit.com,
       linux-kernel@vger.kernel.org, rmk+lkml@arm.linux.org.uk
References: <20050713180210.7DFF621E72A@zion.home.lan> <20050713142918.71bd0b3b.akpm@osdl.org>
In-Reply-To: <20050713142918.71bd0b3b.akpm@osdl.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200507140017.28980.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 13 July 2005 23:29, Andrew Morton wrote:
> Please identify which of these patches you consider to be 2.6.13 material.
All ones are for 2.6.13... except this one, it's still wrong, I overlooked it 
a bit too much, it must be replaced by this (I'll post it in a mail it if 
needed):

http://user-mode-linux.sourceforge.net/work/current/2.6/2.6.12-mm2/patches/x86_64_compile

Bye
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
