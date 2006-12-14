Return-Path: <linux-kernel-owner+w=401wt.eu-S964967AbWLNWjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWLNWjd (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964973AbWLNWjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:39:33 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:1412 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964967AbWLNWjc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:39:32 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=sABIbwWyiC094Vkl/rHzZL+ijBsnT/4vFVlJBtVpIhLWS7NIQbRtXUL7B0ZhWeWCg0jIXKG+X3R2tsJqjRx/6ygU6hx8a5Ffj26win3eYTe5rjj5CFatmdlzMLhd7u3IM41IeSp3B7JQ53+x0JocztyQ16CsUWVaLAL7Pea0Sfo=
Message-ID: <21d7e9970612141439s9ff4652tddd0983d19daeed3@mail.gmail.com>
Date: Fri, 15 Dec 2006 09:39:30 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: "Michael Buesch" <mb@bu3sch.de>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Cc: Alan <alan@lxorguk.ukuu.org.uk>, "Rik van Riel" <riel@redhat.com>,
       "Greg KH" <gregkh@suse.de>, "Jonathan Corbet" <corbet@lwn.net>,
       "Andrew Morton" <akpm@osdl.org>, "Martin Bligh" <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org,
       "Jeff Garzik" <jeff@garzik.org>
In-Reply-To: <200612142326.43295.mb@bu3sch.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061214003246.GA12162@suse.de> <4581726B.9050006@garzik.org>
	 <21d7e9970612141421o79a47705i8a87adbdcbf8b3a9@mail.gmail.com>
	 <200612142326.43295.mb@bu3sch.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >
> > It'll get in when the developers feel it is at a stage where it can be
> > supported, at the moment (I'm not speaking for all the nouveau team
> > only my own opinion) the API isn't stable and putting it into the
> > kernel only means we've declared the API supportable, I know in theory
> > marking it EXPERIMENTAL might work, in practice it will just cause us
> > headaches at this stage, there isn't enough knowledgeable developers
> > working on it both support users and continue development at a decent
> > rate, so mainly ppl are concentrating on development until it can at
> > least play Q3, and for me dualhead on my G5 :-)
>
> To what degree does it work on the G5?
> Can we already drive a desktop system with it?
> I'd like to play around with this on my Quad.
>

2D worked the last time I tested it and fixed up all the problems, it
is slightly faster than nv, but may be more unstable, still only
single head... 3D even on x86 doesn't work yet without pre-loading
nvidia to set the hardware up correctly.. but it's coming along....
there are summary updates posted ~weekly on the nouveau wiki....

Dave.
