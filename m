Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282995AbRK0X4o>; Tue, 27 Nov 2001 18:56:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282994AbRK0X4e>; Tue, 27 Nov 2001 18:56:34 -0500
Received: from mail.pha.ha-vel.cz ([195.39.72.3]:16905 "HELO
	mail.pha.ha-vel.cz") by vger.kernel.org with SMTP
	id <S282987AbRK0X4V>; Tue, 27 Nov 2001 18:56:21 -0500
Date: Wed, 28 Nov 2001 00:56:19 +0100
From: Vojtech Pavlik <vojtech@suse.cz>
To: "Martin A. Brooks" <martin@jtrix.com>
Cc: ast@domdv.de, alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
Subject: Re: 'spurious 8259A interrupt: IRQ7'
Message-ID: <20011128005619.A7340@suse.cz>
In-Reply-To: <XFMail.20011127152007.ast@domdv.de> <1576.10.119.8.1.1006871893.squirrel@extranet.jtrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <1576.10.119.8.1.1006871893.squirrel@extranet.jtrix.com>; from martin@jtrix.com on Tue, Nov 27, 2001 at 02:38:13PM -0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 27, 2001 at 02:38:13PM -0000, Martin A. Brooks wrote:
> > As far as I remember this was talked about earlier. Different mobos,
> > chipsets, processor brands, but always IRQ 7. /me wonders.
> 
> In my research before posting, a common thread seemed to be the presence of
> a tulip card in the machine.  Has anyone seen this on a non-tulip box?

Yep. No tulip in my Athlon Classic, and I've seen it twice today.

-- 
Vojtech Pavlik
SuSE Labs
