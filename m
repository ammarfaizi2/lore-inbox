Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262798AbTELVxD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 May 2003 17:53:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262801AbTELVxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 May 2003 17:53:02 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:34201
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262798AbTELVxA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 May 2003 17:53:00 -0400
Subject: Re: PCMCIA 2.5.X sleeping from illegal context
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Paul Fulghum <paulkf@microgate.com>
Cc: David Hinds <dahinds@users.sourceforge.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1052775331.1995.49.camel@diemos>
References: <1052775331.1995.49.camel@diemos>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052773631.31825.18.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 12 May 2003 22:07:13 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Llu, 2003-05-12 at 22:35, Paul Fulghum wrote:
> The 2.5.X PCMCIA kernel support seems to have a problem
> with drivers/pcmcia/rsrc_mgr.c in function undo_irq().

Does this still happen with all the patches Russell King posted
that everyone else is ignoring ?

