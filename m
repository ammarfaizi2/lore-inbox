Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264213AbUHBWGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264213AbUHBWGS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 18:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbUHBWGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 18:06:18 -0400
Received: from the-village.bc.nu ([81.2.110.252]:29879 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S264213AbUHBWGQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 18:06:16 -0400
Subject: Re: [PATCH] Configure IDE probe delays
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Tim Bird <tim.bird@am.sony.com>
Cc: Todd Poynor <tpoynor@mvista.com>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       dsingleton@mvista.com, vda@port.imtp.ilyichevsk.odessa.ua,
       Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <410EB8A7.1090101@am.sony.com>
References: <20040730191100.GA22201@slurryseal.ddns.mvista.com>
	 <1091226922.5083.13.camel@localhost.localdomain>
	 <410EB8A7.1090101@am.sony.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1091480458.1391.2.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 02 Aug 2004 22:01:01 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2004-08-02 at 22:56, Tim Bird wrote:
> I'm still considering Jeff's comment, and I'll respond to that separately.

If it's done properly everyone wins, and I suspect if you are using
things like CF you will win big time using the PPC spin up delay and not
waiting for disk spin up in the boot firmware.

