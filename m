Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261622AbTCYHyl>; Tue, 25 Mar 2003 02:54:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261625AbTCYHyl>; Tue, 25 Mar 2003 02:54:41 -0500
Received: from bilbo.math.uni-mannheim.de ([134.155.88.153]:64384 "HELO
	bilbo.math.uni-mannheim.de") by vger.kernel.org with SMTP
	id <S261622AbTCYHyk>; Tue, 25 Mar 2003 02:54:40 -0500
From: Rolf Eike Beer <eike-kernel@sf-tec.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.5.66
Date: Tue, 25 Mar 2003 09:05:53 +0100
User-Agent: KMail/1.5
References: <Pine.LNX.4.44.0303241524050.1741-100000@penguin.transmeta.com> <20030325001414.GX18830@iucha.net>
In-Reply-To: <20030325001414.GX18830@iucha.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200303250905.53881@bilbo.math.uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> drivers/char/genrtc.c:100: warning: static declaration for
> `gen_rtc_interrupt' follows non-static
> drivers/char/genrtc.c: In function `gen_rtc_timer':

[...]

It was broken somewhere between -bk1 and -bk4.

Eike
