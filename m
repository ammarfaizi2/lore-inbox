Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267042AbTA0KYw>; Mon, 27 Jan 2003 05:24:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267083AbTA0KYw>; Mon, 27 Jan 2003 05:24:52 -0500
Received: from mpsb-nat02.plala.or.jp ([202.212.114.145]:10584 "EHLO
	mps4.plala.or.jp") by vger.kernel.org with ESMTP id <S267042AbTA0KYw>;
	Mon, 27 Jan 2003 05:24:52 -0500
Date: Mon, 27 Jan 2003 19:34:10 +0900
From: <yokotak@rmail.plala.or.jp>
X-Mailer: EdMax Ver2.85.2F
MIME-Version: 1.0
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gamecon (added support for Sega Saturn controller), kernel 2.4.20
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <20030126113957.A21550@ucw.cz>
References: <20030126113957.A21550@ucw.cz>
Message-Id: <20030127103408.GALG26766.mps4.plala.or.jp@rmail.mail.plala.or.jp>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you very much for your reply.

Vojtech Pavlik <vojtech@suse.cz> wrote:
> Why are you adding it into gamecon.c and not fixing it in db9.c instead?

Db9.c supports ONE gamepad per port. Gamecon.c supports FIVE gamepads
per port.
Gamecon.c seems appropriate to support more than one sega saturn pad
on DPP compatible interface and multitap.

yokota

