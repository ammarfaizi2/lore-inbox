Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932162AbWF2FTf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932162AbWF2FTf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 01:19:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932178AbWF2FTf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 01:19:35 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:28600 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S932162AbWF2FTe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 01:19:34 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=T0HPWTuc5jXo9QG4uuGQvjD8HKVBKAFQrQiw6uBRvULCl8NfyaJlqSgJaD4ReC7dN9k5XBW5Sgy7fKr8sP7TSo7UwQzrkDF7ROWMK/yyMuxp7j41WcdhoaFILIT/o6ZeTAQWTFA6vTvopKeFFdyfln6yv9PHzlaG4ESkJhurYek=
Message-ID: <84144f020606282219n269fffe2i27bdd789758cc268@mail.gmail.com>
Date: Thu, 29 Jun 2006 08:19:32 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: nigel@suspend2.net
Subject: Re: [Suspend2][ 0/9] Extents support.
Cc: "Rahul Karnik" <rahul@genebrew.com>, "Jens Axboe" <axboe@suse.de>,
       "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org
In-Reply-To: <200606290937.31174.nigel@suspend2.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060626165404.11065.91833.stgit@nigel.suspend2.net>
	 <200606282242.26072.nigel@suspend2.net>
	 <84144f020606280742v348bdf53w96bd790362abaff9@mail.gmail.com>
	 <200606290937.31174.nigel@suspend2.net>
X-Google-Sender-Auth: 301ba04257ce409e
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/29/06, Nigel Cunningham <nigel@suspend2.net> wrote:
> Sure, I know where I'd be headed, but it would be a huge waste of time and effort.

Perhaps to you Nigel.  For the rest of us reviewing your patches, it's
much better.  I suspect it would be better for the users down the road
as well.  I don't know if you realize it, but what you're doing now
is, "here's a big chunck of code, take it or leave it".  And at least
historically people have had hard time doing getting stuff merged like
that.

                                                           Pekka
