Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266176AbUAMWiD (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jan 2004 17:38:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUAMWew
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jan 2004 17:34:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:10709 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265929AbUAMWeQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jan 2004 17:34:16 -0500
Date: Tue, 13 Jan 2004 14:30:53 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: martin f krafft <madduck@madduck.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe failed: digest_null
Message-Id: <20040113143053.1c44b97d.rddunlap@osdl.org>
In-Reply-To: <20040113215355.GA3882@piper.madduck.net>
References: <20040113215355.GA3882@piper.madduck.net>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jan 2004 22:53:55 +0100 martin f krafft <madduck@madduck.net> wrote:

| I am seeing many messages like
| 
|   kernel: request_module: failed /sbin/modprobe -- digest_null. error = 256
| 
| in my logs. What's the nature of these?

Any other possibly related messages in the logs?

What kernel version?  like 2.4.2x ??  other patches applied?
[not 2.6.x since modprobe is being used]


--
~Randy
MOTD:  Always include version info.
