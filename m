Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268861AbRIHJnI>; Sat, 8 Sep 2001 05:43:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268896AbRIHJm6>; Sat, 8 Sep 2001 05:42:58 -0400
Received: from [144.137.83.84] ([144.137.83.84]:27381 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S268861AbRIHJms>;
	Sat, 8 Sep 2001 05:42:48 -0400
Message-ID: <3B99E5C8.AEAEF207@eyal.emu.id.au>
Date: Sat, 08 Sep 2001 19:32:56 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Josh McKinney <forming@home.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.10-pre5
In-Reply-To: <3B99A8C2.56E88CE3@isn.net> <003001c1382d$f483d9d0$010da8c0@uglypunk> <20010908014643.A846@home.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Josh McKinney wrote:
> 
> On approximately Sat, Sep 08, 2001 at 03:44:31PM +0930, Kingsley Foreman wrote:
> > Yes i got this too
> > anyone got a fix
> Don't use gcc-3.0

No need to jump the gun, this is a real problem, unrelated to gcc-3.0.

I get the same error with Debian stable 2.2.r3
	$ gcc --version
	2.95.2

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
