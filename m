Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261187AbSJUH2m>; Mon, 21 Oct 2002 03:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261205AbSJUH2m>; Mon, 21 Oct 2002 03:28:42 -0400
Received: from h195202190178.med.cm.kabsi.at ([195.202.190.178]:14221 "EHLO
	phobos.hvrlab.org") by vger.kernel.org with ESMTP
	id <S261187AbSJUH2l>; Mon, 21 Oct 2002 03:28:41 -0400
Subject: Re: [CryptoAPI-devel] Re: [Design] [PATCH] USAGI IPsec
From: Herbert Valerio Riedel <hvr@hvrlab.org>
To: "David S. Miller" <davem@rth.ninka.net>
Cc: Sandy Harris <sandy@storm.ca>, Mitsuru KANDA <mk@linux-ipv6.org>,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       cryptoapi-devel@kerneli.org, design@lists.freeswan.org,
       usagi@linux-ipv6.org
In-Reply-To: <1035168066.4817.1.camel@rth.ninka.net>
References: <m3k7kpjt7c.wl@karaba.org>  <3DB41338.3070502@storm.ca> 
	<1035168066.4817.1.camel@rth.ninka.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 21 Oct 2002 09:34:14 +0200
Message-Id: <1035185654.21824.11.camel@janus.txd.hvrlab.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-10-21 at 04:41, David S. Miller wrote:

> A completely new CryptoAPI subsystem has been implemented so that
> full lists of page vectors can be passed into the ciphers, which is
> necessary for a clean IPSEC implementation.

oh... nice to learn about your plans (so late) at all ;-)

well, it would be cool if you'd cooperate (or at least share
information) with us (the official cryptoapi project ;-), as we're open
for the design requirements of the next generation cryptoapi...

...otherwise this may render the kerneli.org/cryptoapi effort completely
useless :-/ ...of course, if it's your long term goal to take the
cryptoapi development away from kerneli.org, I'd like to know too ;-)

regards,
-- 
Herbert Valerio Riedel       /    Phone: (EUROPE) +43-1-58801-18840
Email: hvr@hvrlab.org       /    Finger hvr@gnu.org for GnuPG Public Key
GnuPG Key Fingerprint: 7BB9 2D6C D485 CE64 4748  5F65 4981 E064 883F
4142

