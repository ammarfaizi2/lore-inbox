Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312365AbSCTLPE>; Wed, 20 Mar 2002 06:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312367AbSCTLOz>; Wed, 20 Mar 2002 06:14:55 -0500
Received: from CPE-203-51-26-136.nsw.bigpond.net.au ([203.51.26.136]:19182
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id <S312365AbSCTLOk>; Wed, 20 Mar 2002 06:14:40 -0500
Message-ID: <3C986F1B.6335F2A2@eyal.emu.id.au>
Date: Wed, 20 Mar 2002 22:14:35 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre3-ac1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.4.19-pre: CONFIG_PHONE_IXJ_PCMCIA
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In drivers/telephony/Config.in

This option should not be offered unless CONFIG_PCMCIA was selected.
While it does build, it ends up with unresolved symbols.

--
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
