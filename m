Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262627AbVFWKO0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262627AbVFWKO0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 06:14:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVFWKLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 06:11:25 -0400
Received: from rproxy.gmail.com ([64.233.170.201]:60642 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S263074AbVFWISW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 04:18:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=YTFdPXNdpFlruui9qc7rrWbF4U9pMUYZ93b1zHtKgZwGz1GDpUiLy2CPX5gFzdJXG30787XBrC87gW65IT09aynHvwFYwkv7YjHlHJ6ZOlxayNA2XbDTkGL+I3o1nhGqIPTvrHxVB07YsPe1UVsBKCbqBBRWX4zLre6+kZMhNi4=
Message-ID: <46a038f9050623011838d6b85f@mail.gmail.com>
Date: Thu, 23 Jun 2005 20:18:22 +1200
From: Martin Langhoff <martin.langhoff@gmail.com>
Reply-To: Martin Langhoff <martin.langhoff@gmail.com>
To: Petr Baudis <pasky@ucw.cz>
Subject: Re: Updated git HOWTO for kernel hackers
Cc: Linus Torvalds <torvalds@osdl.org>, Jeff Garzik <jgarzik@pobox.com>,
       Greg KH <greg@kroah.com>, Linux Kernel <linux-kernel@vger.kernel.org>,
       Git Mailing List <git@vger.kernel.org>
In-Reply-To: <20050623073845.GA5204@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <42B9FCAE.1000607@pobox.com> <42BA14B8.2020609@pobox.com>
	 <Pine.LNX.4.58.0506221853280.11175@ppc970.osdl.org>
	 <42BA1B68.9040505@pobox.com>
	 <Pine.LNX.4.58.0506221929430.11175@ppc970.osdl.org>
	 <42BA271F.6080505@pobox.com>
	 <Pine.LNX.4.58.0506222014000.11175@ppc970.osdl.org>
	 <42BA45B1.7060207@pobox.com>
	 <Pine.LNX.4.58.0506222225010.11175@ppc970.osdl.org>
	 <20050623073845.GA5204@pasky.ji.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/05, Petr Baudis <pasky@ucw.cz> wrote:
> I think there should simply be two namespaces - public tags and private
> tags. Private tags for stuff like "broken", "merged", or "funnychange".

I guess that public tags would also probably be in a different
location from the actual tree. With the split Linus advocates, several
people could be publishing sets of "public" tags, as well as having
the official tags hosted separately from the .git repo.

cheers,


martin
