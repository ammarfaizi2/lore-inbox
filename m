Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750775AbVIEC3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750775AbVIEC3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Sep 2005 22:29:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750838AbVIEC3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Sep 2005 22:29:52 -0400
Received: from web50203.mail.yahoo.com ([206.190.38.44]:22351 "HELO
	web50203.mail.yahoo.com") by vger.kernel.org with SMTP
	id S1750775AbVIEC3v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Sep 2005 22:29:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=fszO4NhaZymF8u+2gJvkdsONp7kcnP19ItsFtGNpKJCbagq3W5X8B+cmKZv0qMT3bf3azPKqNq/5TVjZzHV2uxQNkLBjwTqe3lXbhlvQYXeQhymtUDaAHtF94kaqi8hgOuV3ayMnYjCwYlouT1f3W9ehyRHWRSuKVrn4UMAfl1k=  ;
Message-ID: <20050905022943.46272.qmail@web50203.mail.yahoo.com>
Date: Sun, 4 Sep 2005 19:29:43 -0700 (PDT)
From: Alex Davis <alex14641@yahoo.com>
Subject: re: RFC: i386: kill !4KSTACKS
To: Sean <seanlkml@sympatico.ca>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <39271.10.10.10.10.1125886053.squirrel@linux1>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- Sean <seanlkml@sympatico.ca> wrote:

> On Sun, September 4, 2005 10:00 pm, Alex Davis said:
> > Dave Jones wrote:
> >>- NDISwrapper / driverloader.
> >>  (Shock, horror - no-one cares).
> >
> > Shock, horror. Someone DOES care: everyone who uses ndiswrapper or
> > driverloader, whether they know it or not. Are you proposing that
> > we punish the end-users because of the obstinence of the hardware
> > manufacturers? If/when native drivers are written, maybe we can
> > revisit this.
> 
> 
> Continuing the promotion of binary-only drivers _hurts_ the demand for
> (and thus the development of) open source drivers.  Read the comment from
> Dave as something like "Nobody who matters, with regard to kernel
> development, cares about NDISwrapper".   If _you_ care, fork your own tree
> and maintain the patch as necessary.
> 
> Regards,
> Sean

Sean:

Linux isn't just used by kernel developers. It's that attitude that helps insure
Linux will always have a small userbase. Lack of numbers just gives the manufacturers
another reason not to care about us. Joe User doesn't care about our philosophical
issues, nor should he. When I install Linux on someone's machine, he wants it to work
NOW, not in some 'perfect-world' future. 

-Alex

-Alex
> 


I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
