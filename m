Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261602AbTJMKTc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Oct 2003 06:19:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261605AbTJMKTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Oct 2003 06:19:32 -0400
Received: from mail.gmx.de ([213.165.64.20]:23209 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261602AbTJMKTb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Oct 2003 06:19:31 -0400
X-Authenticated: #1226656
Date: Mon, 13 Oct 2003 12:19:18 +0200
From: Marc Giger <gigerstyle@gmx.ch>
To: achirica@users.sourceforge.net, jt@hpl.hp.com,
       linux-kernel@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>
Subject: Aironet troubles
Message-Id: <20031013121918.091179d6.gigerstyle@gmx.ch>
X-Mailer: Sylpheed version 0.9.4claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier, All

With 2.4.23-pre6 I'm not able to connect to the wireless lan
with the aironet 340 pcmcia card. I've not tried pre7 since it seems
there are no fixes for aironet added.

I have to use dhcpcd to get an IP but I don't get one. Ifconfig shows
that packets ar transmitted, but no single one received. There are also
a lot of errors in rx.

My wireless-tools version: 26

oh, and I have to enable WEP to access the lan.

Thanks

greets

Marc

