Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282841AbRLGP4x>; Fri, 7 Dec 2001 10:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282843AbRLGP4n>; Fri, 7 Dec 2001 10:56:43 -0500
Received: from otter.mbay.net ([206.40.79.2]:9484 "EHLO otter.mbay.net")
	by vger.kernel.org with ESMTP id <S282841AbRLGP4Z> convert rfc822-to-8bit;
	Fri, 7 Dec 2001 10:56:25 -0500
From: John Alvord <jalvo@mbay.net>
To: Horst von Brand <vonbrand@inf.utfsm.cl>
Cc: John Cowan <jcowan@reutershealth.com>, linux-kernel@vger.kernel.org,
        kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5 
Date: Fri, 07 Dec 2001 07:56:15 -0800
Message-ID: <5gp11u40iqo6bj0mj8emav1oe0a8fs0ij4@4ax.com>
In-Reply-To: <jcowan@reutershealth.com>  of "Thu, 06 Dec 2001 17:17:36 CDT." <3C0FEE80.2050603@reutershealth.com> <200112071444.fB7EitoH024769@pincoya.inf.utfsm.cl>
In-Reply-To: <200112071444.fB7EitoH024769@pincoya.inf.utfsm.cl>
X-Mailer: Forte Agent 1.8/32.553
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 07 Dec 2001 11:44:55 -0300, Horst von Brand
<vonbrand@inf.utfsm.cl> wrote:

>John Cowan <jcowan@reutershealth.com> dijo:
>
>[...]
>
>> You only need to learn Python if you are going to change the
>> CML2 compiler or interpreter, not if you are just changing
>> CML2.
>
>I did look around in CML1 when I had some troubles way back. Turned out to
>be my fault, or was fixed in the next patch, so I didn't contribute back.
>Trouble is that another opaque tool makes hacking _harder_, and this in
>turn turns hackers away, and the development suffers.
>
>>       You might as well complain that you must learn
>> Python to hack GNU Mailman.
>
>Just use majordomo ;-)
>
>> CML2 hacking requires knowing Python; kernel hacking does not.
>
>CML2 hacking _is_ kernel hacking, if you like to call it such or not.

I wonder how many people did CML1 tool hacking, fixing up one of the
three (four?) parsers/compilers/runtime. Most people wouldn't know if
those were written in C. sh, or ADA... Those would be the only people
that need to worry about learning Python to do the CML2 tool hacking.

john alvord

