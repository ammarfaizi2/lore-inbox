Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136381AbRD2Vkx>; Sun, 29 Apr 2001 17:40:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132478AbRD2Vko>; Sun, 29 Apr 2001 17:40:44 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:9223 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S136380AbRD2Vkk>; Sun, 29 Apr 2001 17:40:40 -0400
Message-ID: <3AEC8A46.2BA7BF68@transmeta.com>
Date: Sun, 29 Apr 2001 14:40:22 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.0 i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Jim Gettys <jg@pa.dec.com>
CC: dean gaudet <dean-list-linux-kernel@arctic.org>,
        Jeff Garzik <jgarzik@mandrakesoft.com>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: X15 alpha release: as fast as TUX but in user space (fwd)
In-Reply-To: <200104292116.f3TLGhu07016@pachyderm.pa.dec.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Gettys wrote:
> 
> The "put the time into a magic location in shared memory" goes back...
>

Short summary: depending on how much you were talking general idea versus
specifics, you can go arbitrarily far back (I wouldn't be surprised if
shared memory techniques were used regularly before memory protection.)

Fair?

Not to pick on you or anyone else, but it is well-known to everyone
except the U.S. patent office that "there are no new ideas in computer
science." :)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
