Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264423AbRF1VPE>; Thu, 28 Jun 2001 17:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264433AbRF1VOo>; Thu, 28 Jun 2001 17:14:44 -0400
Received: from adsl-64-175-255-50.dsl.sntc01.pacbell.net ([64.175.255.50]:48003
	"HELO kobayashi.soze.net") by vger.kernel.org with SMTP
	id <S264423AbRF1VN7>; Thu, 28 Jun 2001 17:13:59 -0400
Date: Thu, 28 Jun 2001 14:17:17 -0700 (PDT)
From: Justin Guyett <justin@soze.net>
X-X-Sender: <tyme@gw.soze.net>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: james bond <difda@hotmail.com>, <linux-kernel@vger.kernel.org>
Subject: Re: BIG PROBLEM
In-Reply-To: <20010628225908.A7816@bacchus.dhis.org>
Message-ID: <Pine.LNX.4.33.0106281413080.23200-100000@gw.soze.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Ralf Baechle wrote:

> Some versions of the 3c59x driver emit a NUL character on bootup which makes
> klogd suck CPU.  This is fixed in 2.4.5, dunno about 2.4.4.

sysklogd 1.4.1 changelog lists a no busyloop fix.


justin

