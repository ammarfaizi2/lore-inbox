Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262525AbVAJUfw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262525AbVAJUfw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 15:35:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262520AbVAJUcu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 15:32:50 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:22733 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262514AbVAJU2g convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 15:28:36 -0500
Subject: Re: yenta_socket rapid fires interrupts
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: DHollenbeck <dick@softplc.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <41E2BC77.2090509@softplc.com>
References: <41E2BC77.2090509@softplc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Message-Id: <1105383433.12004.107.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 10 Jan 2005 19:24:05 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2005-01-10 at 17:33, DHollenbeck wrote:
> However, when I have a "CARDBUS to USB 2.0 Hi-Speed Adapter" installed 
> at the time of modprobe yenta_socket, I get a problem, shown below.  The 
> same problem occurs if the Adapter is inserted after the yenta module is 
> loaded.  That is, load the yenta_socket module: no problem, then 
> physically insert the Adapter: same problem.

Do other cardbus cards work on this machine ? I'd expect to see 1000
interrupts/second or so off a running USB controller with devices (or
thinking ithas devices) but no more.

> Bitte, was ist?

Sa i'n sŵr ;)

Alan

