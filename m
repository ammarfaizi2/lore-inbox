Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932225AbWDRPMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932225AbWDRPMX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 11:12:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWDRPMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 11:12:23 -0400
Received: from nz-out-0102.google.com ([64.233.162.201]:13086 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S932225AbWDRPMW convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 11:12:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=un7VRWmMKQh+UCfnuqzHwBaiHrheOmdvuPOMAzYCeznLjSnZq8wx+KyuUCeMzONCxJcXC0lIcqaa7vjODatTDLNAQVFUP6y85RX+ViSnXrwcIb36CIPBaTi9VTfkzdNKGTD7HdZh8Z35Ns37c9oV1RdXt1MEuy1tp2X5Rbxsj8k=
Message-ID: <9a8748490604180812i7368fdd3w9e345165d886239@mail.gmail.com>
Date: Tue, 18 Apr 2006 17:12:21 +0200
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Axel Scheepers" <ascheepers@vianetworks.nl>
Subject: Re: oops at reboot/shutdown in device_shutdown
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <4444F060.1090503@vianetworks.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <4444F060.1090503@vianetworks.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/06, Axel Scheepers <ascheepers@vianetworks.nl> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Hi All,
>
> I don't know if this is the right list to report this, if not excuse me
> for posting.
> Since kernel 2.6.16 I experience panics on reboot/shutdown in
> device_shutdown on my dell laptop (pentium-m).
>

Please post those panic messages (complete ones).
It's hard to help you and/or track down the problem without them.

Please also read the REPORTING-BUGS document in the kernel source for
more info that it is usually good to provide. The more detailed info
from you, the greater the chance that someone will find and fix the
bug.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
