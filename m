Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270721AbRIJMDP>; Mon, 10 Sep 2001 08:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270724AbRIJMDG>; Mon, 10 Sep 2001 08:03:06 -0400
Received: from [144.137.83.84] ([144.137.83.84]:6133 "EHLO e4.eyal.emu.id.au")
	by vger.kernel.org with ESMTP id <S270721AbRIJMCy>;
	Mon, 10 Sep 2001 08:02:54 -0400
Message-ID: <3B9CAB2E.8FB4F100@eyal.emu.id.au>
Date: Mon, 10 Sep 2001 21:59:42 +1000
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.10-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Adam J. Richter" <adam@yggdrasil.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: linux-2.4.10-pre7/drivers/sound/i810_audio.c missing definitions
In-Reply-To: <20010910042132.A880@adam.yggdrasil.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Adam J. Richter" wrote:
> 
>         linux-2.4.10-pre7/drivers/sound/i810_audio.c fails to compile,
> because it or some .h file lacks definitions of the following symbols:

Grab 'include/linux/ac97_codec.h' from -ac10.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.anu.edu.au/eyal/>
