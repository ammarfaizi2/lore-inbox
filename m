Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbWFSCUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbWFSCUL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 Jun 2006 22:20:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbWFSCUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 Jun 2006 22:20:11 -0400
Received: from smtp107.mail.mud.yahoo.com ([209.191.85.217]:43646 "HELO
	smtp107.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750707AbWFSCUK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 Jun 2006 22:20:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com.au;
  h=Received:Message-ID:Date:From:User-Agent:X-Accept-Language:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding;
  b=CIe6HOkNbD9SBC8IMkOW//eyyY453Ka1ku4T5eNmKdCr65HUS2LTZGnKIGOt3rXLBmScQxvVLsJWlmkzjake1EZ/OiGvGQGbsp+o+VjPgYXftWHPC9fzFj/x0/uzvwA9Nu+ku4xHbxg2vMpBv6mYBxedCy5H7FGaTfnODsx8pH0=  ;
Message-ID: <4495F469.5060100@yahoo.com.au>
Date: Mon, 19 Jun 2006 10:48:41 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20051007 Debian/1.7.12-1
X-Accept-Language: en
MIME-Version: 1.0
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
CC: Greg KH <gregkh@suse.de>, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       greg@kroah.com
Subject: Re: [GIT PATCH] Remove devfs from 2.6.17
References: <20060618221343.GA20277@kroah.com> <20060618230041.GG4744@bouh.residence.ens-lyon.fr> <20060618231204.GB2212@suse.de> <20060618233508.GH4744@bouh.residence.ens-lyon.fr>
In-Reply-To: <20060618233508.GH4744@bouh.residence.ens-lyon.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel Thibault wrote:
> Hi,
> 
> Greg KH, le Sun 18 Jun 2006 16:12:04 -0700, a écrit :
> 

>>And this whole thing has nothing to do with devfs, as you stated above
>>:)
> 
> 
> Ok, but devfs had let me some hope that it would work, and udev doesn't
> so much (the abovementioned links.conf file is considered hacky).

Could you do it with FUSE?

-- 
SUSE Labs, Novell Inc.
Send instant messages to your online friends http://au.messenger.yahoo.com 
