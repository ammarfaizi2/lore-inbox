Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265736AbSL3TnV>; Mon, 30 Dec 2002 14:43:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265777AbSL3TnV>; Mon, 30 Dec 2002 14:43:21 -0500
Received: from router.go.cz ([62.24.94.222]:63361 "EHLO napalm.go.cz")
	by vger.kernel.org with ESMTP id <S265736AbSL3TnU>;
	Mon, 30 Dec 2002 14:43:20 -0500
Date: Mon, 30 Dec 2002 20:52:06 +0100
From: Jan Dvorak <jan.dvorak@kraxnet.cz>
To: linux-kernel@vger.kernel.org
Subject: PPP problems in 2.4.19-20, modem freezes
Message-ID: <20021230205206.A2196@go.cz>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.11i
Organization: (www.kraxnet.cz)
X-URL: http://www.johnydog.cz/
X-OS: Linux 2.4.20 i686
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm running leased line between two 28.8k external modems, with pppd 2.4.1.
After upgrading kernel to 2.4.19, i've experienced modem freezes - when the
connection dies and modem (the one switched to recieve) hangs up, sometimes it 'freezes', not reacting at any inputs from terminal program/pppd, emiting weird
signal to the line (that tone you got when the line is aborted while
handshaking, but this time it won't time out). Killing pppd or even
rebooting the machine doesn't help, i must manually cycle the modem to start working again.
With older kernels (2.4.16) it works fine. Any ideas ?

Please CC replies to me, as i'm not on the list.

Thanks, Jan

