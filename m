Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262427AbVAZQ6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262427AbVAZQ6z (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Jan 2005 11:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbVAZQ5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Jan 2005 11:57:22 -0500
Received: from wproxy.gmail.com ([64.233.184.203]:23437 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262351AbVAZQzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Jan 2005 11:55:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=XUXrJzwhOBop+0KQR9f6a0qAJPL8T8SQhxckvaaJgaSMIVIpEwZ+JjMR10mHQnZ3K5FD/TVJ7y6vx3go42GHNn27Q7Gs4Yz9x47Aa/n+qQE16CLPvR4K1+Lv5FN3YFoGhJ7It0eYpzFrNJhSJyRG2cQsaY/NRuw9EMSnjGUBNBA=
Message-ID: <d4b385205012608272e300b1b@mail.gmail.com>
Date: Wed, 26 Jan 2005 17:27:46 +0100
From: Mikkel Krautz <krautz@gmail.com>
Reply-To: Mikkel Krautz <krautz@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] TIGLUSB Cleanups
Cc: greg@kroah.com, roms@lpg.ticalc.org, jb@technologeek.org
In-Reply-To: <41F7BF8D.70205@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <41F7BF8D.70205@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 17:04:29 +0100, Mikkel Krautz <krautz@gmail.com> wrote:
> Hello!
> 
> The tiglusb-driver was removed in 2.6.11-rc1.
> 
> Since then, references to it in other files have been kept, namely the
> following files:
> 
>     Documentation/usb/silverlink.txt,
>     Documentation/kernel-parameters.txt
>     MAINTAINERS
> 
> This series of patches removes the silverlink.txt-documentation, and
> tiglusb-references in MAINTAINERS and kernel-parameters.txt.
> 
> The patches are diffed against 2.6.11-rc2-bk4.
> 
> Thanks,
> Mikkel Krautz
> 

Hurrah!

All the patches were word-wrapped by Thunderbird, even though I disabled it.

I'm sorry, but this is all I can do for now. Sigh.

Thanks,
Mikkel Krautz
