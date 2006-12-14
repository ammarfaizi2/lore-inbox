Return-Path: <linux-kernel-owner+w=401wt.eu-S964882AbWLNWVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964882AbWLNWVr (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 17:21:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964863AbWLNWVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 17:21:47 -0500
Received: from ug-out-1314.google.com ([66.249.92.175]:39204 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964882AbWLNWVq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 17:21:46 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=A05fFi/7iI/4S+8lCJh2MesOV8zO2bSrR0coG7tD2O1B+vP8wH3ekbpsP+tgaiwiSY/s6djGCImO/Od05iqdiGjEbceQBU/n5HPO7y1ic4BgxX4jFLqyguW4758reyCkps1zaesduNPDBc4Sb/dMGA/4P2kwJ8arL4gQrGk/B54=
Message-ID: <21d7e9970612141421o79a47705i8a87adbdcbf8b3a9@mail.gmail.com>
Date: Fri, 15 Dec 2006 09:21:45 +1100
From: "Dave Airlie" <airlied@gmail.com>
To: "Jeff Garzik" <jeff@garzik.org>
Subject: Re: GPL only modules [was Re: [GIT PATCH] more Driver core patches for 2.6.19]
Cc: Alan <alan@lxorguk.ukuu.org.uk>, "Rik van Riel" <riel@redhat.com>,
       "Greg KH" <gregkh@suse.de>, "Jonathan Corbet" <corbet@lwn.net>,
       "Andrew Morton" <akpm@osdl.org>, "Martin Bligh" <mbligh@mbligh.org>,
       "Michael K. Edwards" <medwards.linux@gmail.com>,
       "Linus Torvalds" <torvalds@osdl.org>, linux-kernel@vger.kernel.org
In-Reply-To: <4581726B.9050006@garzik.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061214003246.GA12162@suse.de> <22299.1166057009@lwn.net>
	 <20061214005532.GA12790@suse.de>
	 <20061214051015.GA3506@nostromo.devel.redhat.com>
	 <20061214084820.GA29311@suse.de> <4581595C.7080508@redhat.com>
	 <20061214154734.189a23c6@localhost.localdomain>
	 <4581726B.9050006@garzik.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/15/06, Jeff Garzik <jeff@garzik.org> wrote:
> Alan wrote:
> > Another thing we should do more is aggressively merge prototype open
> > drivers for binary only hardware - lets get Nouveau's DRM bits into the
> > kernel ASAP for example.
>
> ACK++  We should definitely push Nouveau[1] as hard as we can.
>
>         Jeff
>

It'll get in when the developers feel it is at a stage where it can be
supported, at the moment (I'm not speaking for all the nouveau team
only my own opinion) the API isn't stable and putting it into the
kernel only means we've declared the API supportable, I know in theory
marking it EXPERIMENTAL might work, in practice it will just cause us
headaches at this stage, there isn't enough knowledgeable developers
working on it both support users and continue development at a decent
rate, so mainly ppl are concentrating on development until it can at
least play Q3, and for me dualhead on my G5 :-)

Dave.
