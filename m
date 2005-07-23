Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261773AbVGWPqn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261773AbVGWPqn (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Jul 2005 11:46:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262140AbVGWPo0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Jul 2005 11:44:26 -0400
Received: from wproxy.gmail.com ([64.233.184.204]:32938 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262087AbVGWPmb convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Jul 2005 11:42:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=cJJEfJsCFoH9LIwfQJY5jOIJps6A+VtqpVKc8zRKjOZCM6PLwxeVQs+FpKl1LIgG17hHxkXnQCEis4gBQPEYRqOdPaCHziFGL+nLMvvw+h4J24CZWc7f8AFAgGxebidvipLyMtJoypU9fGMOn2GIj/SOO9K26KuWIVuGZhO8Gxc=
Message-ID: <c0140e7605072308424eb60d57@mail.gmail.com>
Date: Sat, 23 Jul 2005 17:42:26 +0200
From: cengizkirli <cengizkirli@gmail.com>
Reply-To: cengizkirli <cengizkirli@gmail.com>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: Mouse Freezes in Xorg on ASUS P4C800 Deluxe
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <9a8748490507230836584948c6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <c0140e76050723082730836e7b@mail.gmail.com>
	 <9a8748490507230836584948c6@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/23/05, Jesper Juhl <jesper.juhl@gmail.com> wrote:
> On 7/23/05, cengizkirli <cengizkirli@gmail.com> wrote:
> > distro: Debian Unstable
> > kernels tested with: 2.6.13-rc3, 2.6.13-rc3-git5, 2.6.13-rc3-mm1
> > compiler used: Debian gcc-4.0.1-2
> > Xorg: Debian xorg-6.8.2-4
> > ASUS P4C800 Deluxe BIOS: 1019 (2005-11-08)
> >
> > with or wihout ACPI enabled (acpi=off or not) the /dev/input/mice USB
> > mouse freezes after not being used for some time and can only be
> > awakened by switching to the text-console and back.
> >
> What's the last kernel it works OK with?

none I can remember as I did not run linux that much on this box
prior to last winter.

this also happened before the Debian Unstable Xorg switch and
therefore with XFree86.

> Why do you suspect this to be a kernel problem and not a X.org problem?

because they told me in the Xorg IRC channel to believe in a kernel
problem.
