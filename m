Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbUCVWBa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 17:01:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbUCVWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 17:01:18 -0500
Received: from magic.adaptec.com ([216.52.22.17]:5021 "EHLO magic.adaptec.com")
	by vger.kernel.org with ESMTP id S263709AbUCVWAq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 17:00:46 -0500
Message-ID: <405F61C1.9090907@adaptec.com>
Date: Mon, 22 Mar 2004 14:59:29 -0700
From: Scott Long <scott_long@adaptec.com>
User-Agent: Mozilla/5.0 (X11; U; FreeBSD i386; en-US; rv:1.4) Gecko/20030817
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjanv@redhat.com
CC: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jeff Garzik <jgarzik@pobox.com>, "Justin T. Gibbs" <gibbs@scsiguy.com>,
       linux-raid@vger.kernel.org, "Gibbs, Justin" <justin_gibbs@adaptec.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: "Enhanced" MD code avaible for review
References: <459805408.1079547261@aslan.scsiguy.com> <4058A481.3020505@pobox.com> <4058C089.9060603@adaptec.com> <200403172245.31842.bzolnier@elka.pw.edu.pl> <4058EBEC.8070309@adaptec.com> <1079788027.5225.4.camel@laptop.fenrus.com>  <405E287E.3080706@adaptec.com> <1079946343.5296.5.camel@laptop.fenrus.com>
In-Reply-To: <1079946343.5296.5.camel@laptop.fenrus.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Mon, 2004-03-22 at 00:42, Scott Long wrote:
> 
> 
>>Well, code speaks louder than words, as this group loves to say.  I 
>>eagerly await your code.  Barring that, I eagerly await a technical
>>argument, rather than an emotional "you're wrong because I'm right"
>>argument.
> 
> 
> I think that all the arguments for using DM are techinical arguments not
> emotional ones. oh well.. you're free to write your code I'm free to not
> use it in my kernels ;)

Ok, the technical arguments I've heard in favor of the DM approach is 
that it reduces kernel bloat.  That fair, and I certainly agree with not
putting the kitchen sink into the kernel.  Our position on EMD is that
it's a special case because you want to reduce the number of failure
modes, and that it doesn't contribute in a significant way to the kernel
size.  Your response to that our arguments don't matter since your mind
is already made up.  That's the barrier I'm trying to break through and
have a techincal discussion on.

Scott

