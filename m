Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267449AbUI0XTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267449AbUI0XTP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 19:19:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUI0XTP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 19:19:15 -0400
Received: from adsl-63-197-226-105.dsl.snfc21.pacbell.net ([63.197.226.105]:41344
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S267449AbUI0XTE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 19:19:04 -0400
Date: Mon, 27 Sep 2004 16:18:45 -0700
From: "David S. Miller" <davem@davemloft.net>
To: CaT <cat@zip.com.au>
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       linux-net@vger.kernel.org, netdev@oss.sgi.com
Subject: Re: strange network slowness in 2.6 unless pingflooding
Message-Id: <20040927161845.1442bb4a.davem@davemloft.net>
In-Reply-To: <20040927224957.GA1043@zip.com.au>
References: <20040927090342.GA1794@zip.com.au>
	<41587A26.6020606@conectiva.com.br>
	<20040927224957.GA1043@zip.com.au>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 28 Sep 2004 08:49:57 +1000
CaT <cat@zip.com.au> wrote:

> It does not help. Same problem as before.

Please give us some exact specifics about your network setup
so that someone can possibly reproduce your problem locally.
In particular, if there are hubs or switches involved on
your local network that might be getting the duplex wrong,
or some NAT or firewall machines in the path in question,
please specify their setup precisely.

Otherwise there is zero chance of this problem ever being
fixes.
