Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965090AbVJEJ5J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965090AbVJEJ5J (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 05:57:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965091AbVJEJ5J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 05:57:09 -0400
Received: from free.hands.com ([83.142.228.128]:62370 "EHLO free.hands.com")
	by vger.kernel.org with ESMTP id S965090AbVJEJ5I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 05:57:08 -0400
Date: Wed, 5 Oct 2005 10:56:53 +0100
From: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Marc Perkel <marc@perkel.com>, linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
Message-ID: <20051005095653.GK10538@lkcl.net>
References: <20051002204703.GG6290@lkcl.net> <4342DC4D.8090908@perkel.com> <200510050122.39307.dhazelton@enter.net> <4343694F.5000709@perkel.com> <17219.39868.493728.141642@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17219.39868.493728.141642@gargle.gargle.HOWL>
User-Agent: Mutt/1.5.5.1+cvs20040105i
X-hands-com-MailScanner: Found to be clean
X-MailScanner-From: lkcl@lkcl.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2005 at 01:24:12PM +0400, Nikita Danilov wrote:

> Marc Perkel writes:
> 
> [...]
> 
>  > Right - that's Unix "inside the box" thinking. The idea is to make the 
>  > operating system smarter so that the user doesn't have to deal with 
>  > what's computer friendly - but reather what makes sense to the user. 
>  >  From a user's perspective if you have not rights to access a file then 
>  > why should you be allowed to delete it?
> 
> Because in Unix a name is not an attribute of a file.
 
 there is no excuse.

 selinux has already provided an alternative that is similar to NW
 file permissions.

 so there is no excuse.

 think about this.

 in what way is it possible for linux to fully support the NTFS
 filesystem?

 bearing in mind that you will need to communicate a little bit more
 than, but the direct equivalent of unix uid gid and secondary groups,
 from userspace into kernelspace - just like reading /etc/passwd but
 instead reading from a userspace daemon.

 l.

