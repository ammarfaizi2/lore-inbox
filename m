Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313314AbSDJQmh>; Wed, 10 Apr 2002 12:42:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313315AbSDJQmh>; Wed, 10 Apr 2002 12:42:37 -0400
Received: from c2ce9fba.adsl.oleane.fr ([194.206.159.186]:11678 "EHLO
	avalon.france.sdesigns.com") by vger.kernel.org with ESMTP
	id <S313314AbSDJQmf>; Wed, 10 Apr 2002 12:42:35 -0400
To: Anton Altaparmakov <aia21@cus.cam.ac.uk>
Cc: Emmanuel Michon <emmanuel_michon@realmagic.fr>,
        linux-kernel@vger.kernel.org
Subject: Re: module programming smp-safety howto?
In-Reply-To: <Pine.SOL.3.96.1020410142815.250A-100000@draco.cus.cam.ac.uk>
From: Emmanuel Michon <emmanuel_michon@realmagic.fr>
Date: 10 Apr 2002 18:42:31 +0200
Message-ID: <7whemjbj48.fsf@avalon.france.sdesigns.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.1 (Cuyahoga Valley)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Altaparmakov <aia21@cus.cam.ac.uk> writes:

> http://www.moses.uklinux.net/patches/lki.html

thanks!

> Also, are we going to see the driver published under GPL (I sure hope
> so!) or is it going to be binary only as per usual Sigma Designs policy?

The core library (supporting the PCI chip and all devices attached
thru its i2c) is binary only.

The connection between the usual linux module api and this library
comes as source code for but is not GPL (NVIDIA driver like).

Unfortunately I personnally do not decide of this: many engineers work
at Sigma, with various backgrounds.

[This mail is a bit off topic, sorry. Any following discussion will
be completely for sure]

Sincerely yours,

-- 
Emmanuel Michon
Chef de projet
REALmagic France SAS
Mobile: 0614372733 GPGkeyID: D2997E42  
