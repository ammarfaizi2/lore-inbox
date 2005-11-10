Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbVKJOsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbVKJOsd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Nov 2005 09:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750977AbVKJOsd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Nov 2005 09:48:33 -0500
Received: from rtr.ca ([64.26.128.89]:37057 "EHLO mail.rtr.ca")
	by vger.kernel.org with ESMTP id S1750973AbVKJOsc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Nov 2005 09:48:32 -0500
Message-ID: <43735DCA.7060107@rtr.ca>
Date: Thu, 10 Nov 2005 09:48:42 -0500
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>, Jan Beulich <JBeulich@novell.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/39] NLKD - Novell Linux Kernel Debugger
References: <43720DAE.76F0.0078.0@novell.com>  <43722AFC.4040709@pobox.com> <1131558785.6540.34.camel@localhost.localdomain>
In-Reply-To: <1131558785.6540.34.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
>
> I think it is clearly the case that the design is wrong. The existance
> of kgdb shows how putting the complex logic remotely on another system
> is not only a lot cleaner and simpler but can also provide more
> functionality and higher reliability.

Unless the target machine is modern (2005+ era) and has no serial ports,
nor any way to add them other than via the USB stack.

Cheers
