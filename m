Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265402AbRGCRTw>; Tue, 3 Jul 2001 13:19:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265412AbRGCRTm>; Tue, 3 Jul 2001 13:19:42 -0400
Received: from adsl-dynamic2-173.milwaukee.wi.ameritech.net ([64.108.133.173]:49657
	"HELO alphaflight.0xd6.org") by vger.kernel.org with SMTP
	id <S265402AbRGCRT0>; Tue, 3 Jul 2001 13:19:26 -0400
Date: Tue, 3 Jul 2001 12:18:24 -0500
From: "M. R. Brown" <mrbrown@0xd6.org>
To: "Eric S. Raymond" <esr@snark.thyrsus.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Cross-reference analysis reveals problems in 2.4.6pre9
Message-ID: <20010703121824.B16450@0xd6.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200107031642.f63GgEG25604@snark.thyrsus.com>
User-Agent: Mutt/1.3.18i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Eric S. Raymond <esr@snark.thyrsus.com> on Tue, Jul 03, 2001:

> According to my cross-reference generator, the following symbols have
> missing help in 2.4.6-pre9:
> 
[...]
> CONFIG_MAPLE
> CONFIG_MAPLE_KEYBOARD
> CONFIG_MAPLE_MOUSE

These three are for the Dreamcast driver port.  I can write help entries
for them, but I don't think NIIBE has sent SuperH updates in awhile, the
only missing symbol is CONFIG_INPUT_MAPLE_CONTROL, I'll write that one as
well.

M. R.
