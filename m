Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278593AbRJXPsd>; Wed, 24 Oct 2001 11:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278609AbRJXPsX>; Wed, 24 Oct 2001 11:48:23 -0400
Received: from etna.trivadis.com ([193.73.126.2]:28404 "EHLO lttit")
	by vger.kernel.org with ESMTP id <S278605AbRJXPsM>;
	Wed, 24 Oct 2001 11:48:12 -0400
Date: Wed, 24 Oct 2001 17:45:31 +0200
From: Tim Tassonis <timtas@dplanet.ch>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fdisk: "File size limit exceeded on fdisk" 2.4.10 to 2.4.13-pre6
In-Reply-To: <E15wPwW-0001oq-00@the-village.bc.nu>
In-Reply-To: <E15wPed-0000HM-00@lttit>
	<E15wPwW-0001oq-00@the-village.bc.nu>
X-Mailer: Sylpheed version 0.6.3cvs10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <E15wQDj-0000HT-00@lttit>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Oct 2001 16:27:44 +0100 (BST)
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> > When I try to create a partition of 2GB using fdisk or parted, I get
the
> > error "File size limit exceeded (core dumped)". I already read about
this
> > error on the mailing list, but sadly not of any solution.
> 
> Make sure you have limits set right and a new enough glibc. 

I'm using a Red Hat 6.2 system with glibc 2.1.3 (glibc-2.1.3-22), the
latest for Red Hat 6.2. Switching to 7.x would mean to upgrade the whole
system, I guess I can't just take the glibc rpm out of 7.x and everything
still runs fine?

So that means I'm really fucked?

Bye
Tim
