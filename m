Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131642AbRCOEPJ>; Wed, 14 Mar 2001 23:15:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131643AbRCOEO7>; Wed, 14 Mar 2001 23:14:59 -0500
Received: from saturn.cs.uml.edu ([129.63.8.2]:12812 "EHLO saturn.cs.uml.edu")
	by vger.kernel.org with ESMTP id <S131642AbRCOEOl>;
	Wed, 14 Mar 2001 23:14:41 -0500
From: "Albert D. Cahalan" <acahalan@cs.uml.edu>
Message-Id: <200103150412.f2F4Cl563158@saturn.cs.uml.edu>
Subject: Re: [PATCH] Improved version reporting
To: viro@math.psu.edu (Alexander Viro)
Date: Wed, 14 Mar 2001 23:12:47 -0500 (EST)
Cc: Andries.Brouwer@cwi.nl, alan@lxorguk.ukuu.org.uk, linus@transmeta.com,
        rhw@memalpha.cx, linux-kernel@vger.kernel.org,
        seberino@spawar.navy.mil
In-Reply-To: <Pine.GSO.4.21.0103141114170.4468-100000@weyl.math.psu.edu> from "Alexander Viro" at Mar 14, 2001 11:26:51 AM
X-Mailer: ELM [version 2.5 PL2]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexander Viro writes:
> On Wed, 14 Mar 2001 Andries.Brouwer@cwi.nl wrote:

>>> +o  Console Tools      #   0.3.3        # loadkeys -V
>>> +o  Mount              #   2.10e        # mount --version
>>
>> Concerning mount: (i) the version mentioned is too old,

Exactly why? Mere missing features don't make for a required
upgrade. Version number inflation should be resisted.

>> Concerning Console Tools: maybe kbd-1.05 is uniformly better.
>> I am not aware of any reason to recommend the use of console-tools.
>
> Debian has console-tools with priority:required and kbd
> with priority:extra. Take it with Yann Dirson...

Both should be "extra". They can be removed from the version script.
I'm even one of the few remaining console users.
