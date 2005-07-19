Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261412AbVGSXDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261412AbVGSXDy (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 19 Jul 2005 19:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261421AbVGSXDy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Jul 2005 19:03:54 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:55633 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261412AbVGSXDx convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Jul 2005 19:03:53 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Q53Ejay/gghUyasZSiTLrBvm3/V3DzufBWeeEfGPqgsCYsFUjJMhbPnsXkz8A4G+gQsDmtwJSm+BLOd28kFvilUySnUkiud76b+Sm0A9JRMVhA3tJx1xmFK11uEinqBBXyQJPYX2+AgDl6dkckcEijPJTCWYkY5dzJEk/IfQciU=
Message-ID: <4de7f8a605071916022f019cd0@mail.gmail.com>
Date: Wed, 20 Jul 2005 01:02:57 +0200
From: Jan Blunck <jblunck@gmail.com>
Reply-To: j.blunck@tu-harburg.de
To: omb@bluewin.ch
Subject: Re: how to be (SAFE) a kernel developer ?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <42DD7644.5040304@khandalf.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5a3ed56505071807357fc419e7@mail.gmail.com>
	 <9a87484905071818116f7cb0de@mail.gmail.com>
	 <42DD7644.5040304@khandalf.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/19/05, Brian O'Mahoney <omb@khandalf.com> wrote:
> 
> sacrifical system, and, for example NFS mount everything, on
> it from your main box, otherwise use a cheap local disk just
> for your fs stuff
> 
> then when you blow it there is no FS damage and you don't need
> to wait for FSCK, or Journal Replay, when your fs works you
> can live more dangerously ;-)
> 

Or try qemu/bochs for your laptop, Xen for your desktop and z/VM for
your mainframe ;)

Jan
