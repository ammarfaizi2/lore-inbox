Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262568AbRGIQRO>; Mon, 9 Jul 2001 12:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262715AbRGIQQy>; Mon, 9 Jul 2001 12:16:54 -0400
Received: from t2.redhat.com ([199.183.24.243]:52725 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S262682AbRGIQQu>; Mon, 9 Jul 2001 12:16:50 -0400
X-Mailer: exmh version 2.3 01/15/2001 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20010706080937.A22601@thyrsus.com> 
In-Reply-To: <20010706080937.A22601@thyrsus.com> 
To: esr@thyrsus.com
Cc: CML2 <linux-kernel@vger.kernel.org>, kbuild-devel@lists.sourceforge.net,
        ralf@uni-koblenz.de
Subject: Re: Current list of the missing-in-action 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 09 Jul 2001 17:16:43 +0100
Message-ID: <21722.994695403@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


esr@thyrsus.com said:
> CONFIG_GDB_CONSOLE

Mea Culpa.

Console output to GDB
CONFIG_GDB_CONSOLE
  If you are using GDB for remote debugging over a serial port and would
  like kernel messages to be formatted into GDB $O packets so that GDB
  prints them as program output, say 'Y'.

--
dwmw2


