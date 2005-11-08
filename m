Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965017AbVKHVpO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965017AbVKHVpO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Nov 2005 16:45:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965037AbVKHVpO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Nov 2005 16:45:14 -0500
Received: from xproxy.gmail.com ([66.249.82.203]:39733 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S965017AbVKHVpM convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Nov 2005 16:45:12 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=jq03UZ+jV0YISSMUyY80Jw8w7w+2QO+UxWkyyVLj0hY/97QLqelEl4k2kcn5t0M5E/dCphwbV+AN5Pn6wVVobbjy/j2MuEvjJ8g+UnDlB5B8RXHtsnzIkvEsQVQ/07W3FbbFl2cN4aNWcenkovoBvL7sxZiub+5S2DmdpqXWFbM=
Message-ID: <fb7befa20511081345l497846abla28f978fc4e45442@mail.gmail.com>
Date: Tue, 8 Nov 2005 16:45:12 -0500
From: Adayadil Thomas <adayadil.thomas@gmail.com>
To: Chris Largret <largret@gmail.com>
Subject: Re: Creating new System.map with modules symbol info
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1131484787.5520.3.camel@shogun.daga.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <fb7befa20511081304sec70208l5d1a464e5af78f58@mail.gmail.com>
	 <1131484787.5520.3.camel@shogun.daga.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the reply.

Usage of mksysmap is --
mksysmap vmlinux System.map

How do I specify the module which is not included in the kernel ?
Is that possible ?

Thanks

On 11/8/05, Chris Largret <largret@gmail.com> wrote:
> On Tue, 2005-11-08 at 16:04 -0500, Adayadil Thomas wrote:
> > Greetings.
> >
> > The System map that was created when compiling kernel does'nt have the symbols
> > of modules that are loaded later. How can I create a new System.map
> > with the symbols of
> > modules also.
>
> >From the linux kernel source directory, take a look at scripts/mksysmap.
>
> --
> Chris Largret <http://daga.dyndns.org>
>
>
