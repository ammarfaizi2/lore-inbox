Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVCWQpl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVCWQpl (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Mar 2005 11:45:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262729AbVCWQoM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Mar 2005 11:44:12 -0500
Received: from web52209.mail.yahoo.com ([206.190.39.91]:61085 "HELO
	web52209.mail.yahoo.com") by vger.kernel.org with SMTP
	id S262730AbVCWQlk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Mar 2005 11:41:40 -0500
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  b=coagYmlqoQmEzWTX2FKlzQZsz5vQ+R0cAYrhU8WpE60JCML/jFKDg821KGzUyGi+Pccleb0mv5jtlG55Pv/lvzIqJZm5RKANKXgtpn+MAZvNj4PjndIACkf7j8dV+K5p57aC8HPNTSG42AU+U7F3drdLurf3iwAuPCzP5gIIpnk=  ;
Message-ID: <20050323164139.49885.qmail@web52209.mail.yahoo.com>
Date: Wed, 23 Mar 2005 08:41:39 -0800 (PST)
From: linux lover <linux_lover2004@yahoo.com>
Subject: Re: Accessing data structure from kernel space
To: Jan Engelhardt <jengelh@linux01.gwdg.de>, linux-kernel@vger.kernel.org
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello sir,
--- Jan Engelhardt <jengelh@linux01.gwdg.de> wrote:
> >> Hello all,
> >>       I have one linked list data structure added
> to
> >> a file in kernel source code which has some
> kernel
> >> info. I want to acess that linked list structure
> from
> >> user space. Is that possible??
> 
> Yes!!
        So that mean i can read that linked list
structure and print them in user space that will have
some kernel internel info.
> 
> >>       Also how to add own system call usable at
> user
> >> level from kernel module??
> 
> !!
> 
> > Many people will tell you to use the /proc
> file-system.
> 
> *cough* sysfs *cough*
> err...(due to new horizons):
> *cough* relayfs *cough*
> 
> 

     Whats that? Can you please elaborate to me as i
am newbie to those words. Pleaseeee.

> 
> Jan Engelhardt
> -- 
> 

Thanks in advance.
regards,
linux_lover.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
