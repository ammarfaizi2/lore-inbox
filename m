Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261246AbVC0Rwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261246AbVC0Rwr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Mar 2005 12:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261268AbVC0Rwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Mar 2005 12:52:47 -0500
Received: from rproxy.gmail.com ([64.233.170.201]:32297 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261246AbVC0Rw3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Mar 2005 12:52:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=J/kwA9N03+r/S86XWYFNxFx7Vf4CqSP2emQ+zZ56rXDBNx+Y7F9v8/10PxhbCM6ZNJF3ojhH/uoGJ4ev5kUhyciFFG1RQdCP0spVfKcg1AhwgQQsSVefc637LimXBHN6vjmzJ/l8yRPrCiIlQwoKHtjIL07m/1ya4GAKPpIe4CU=
Message-ID: <21d7e99705032709525a90e55b@mail.gmail.com>
Date: Mon, 28 Mar 2005 03:52:28 +1000
From: Dave Airlie <airlied@gmail.com>
Reply-To: Dave Airlie <airlied@gmail.com>
To: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Can't use SYSFS for "Proprietry" driver modules !!!.
Cc: Arjan van de Ven <arjan@infradead.org>, Aaron Gyes <floam@sh.nu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <1111886147.1495.3.camel@localhost>
	 <490243b66dc7c3f592df7a7d0769dcb7@mac.com>
	 <1111913399.6297.28.camel@laptopd505.fenrus.org>
	 <16d78e9ea33380a1f1ad90c454fb6e1d@mac.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> This email is Copyright (C) 2005 Kyle Moffett.
> 
> The remainder of this email is available under the GNU General Public
> License, version 2.  See http://www.gnu.org/licenses/gpl.txt for
> details.
> THE BELOW MAY NOT BE USED IN A BINARY DRIVER, SO DON'T EVEN THINK ABOUT
> IT!
> </flame>
> 
> Ok, so what if the _driver_ provides an API like this:
> 
> int start_driver(void);
> int stop_driver(void);
> void register_alloc(void *(*alloc)(unsigned long));
> void register_free(void (*free)(void *));
> [... more register functions here, generic functionality ...]
> 

#GPL this e-mail my first C program,..
int main(int argc, char **argv)
{
}

damn every C program is a derived work.. it just means you need to get
a better lawyer... more than likely American courts will be involved..
I suggest the Chewbacca defence[1] will work if you can pay enough
money....

Dave.

[1] http://en.wikipedia.org/wiki/Chewbacca_defence
