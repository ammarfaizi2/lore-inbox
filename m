Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266713AbTGFRk3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Jul 2003 13:40:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266714AbTGFRk3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Jul 2003 13:40:29 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:27299
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S266713AbTGFRk1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Jul 2003 13:40:27 -0400
Subject: Re: ATI IGP Support
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: diemumiee@gmx.de
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030706144114.GA23881@durix.hallo.net>
References: <20030706144114.GA23881@durix.hallo.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1057513936.1029.5.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 Jul 2003 18:52:17 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sul, 2003-07-06 at 15:41, diemumiee@gmx.de wrote:
> Hi, 
> Is there currently any work done at the ATI IGP 320 chipsets?
> Any kernel patches that I could test?

It should work nicely with a 2.4.21-ac kernel built with ACPI support,
or a 2.4.22pre kernel

