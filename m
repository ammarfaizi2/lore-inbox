Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262940AbVAFRis@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbVAFRis (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262934AbVAFRfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:35:55 -0500
Received: from clock-tower.bc.nu ([81.2.110.250]:43707 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S262931AbVAFRe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:34:57 -0500
Subject: Re: 2.6.10: "[permanent]" modules?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: linux-os@analogic.com, Christoph Hellwig <hch@infradead.org>,
       Harald Dunkel <harald@coware.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <58cb370e05010605584cdcd400@mail.gmail.com>
References: <41DCE48E.5010604@coware.com>
	 <20050106092858.GB15162@infradead.org>
	 <Pine.LNX.4.61.0501060744330.17811@chaos.analogic.com>
	 <58cb370e05010605584cdcd400@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1105023878.17176.217.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 06 Jan 2005 16:30:22 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2005-01-06 at 13:58, Bartlomiej Zolnierkiewicz wrote:
> It can be unloaded given that the needed locking
> and cleanup code are in place...

ie 2.6.10-ac, although I've only enabled it for a few controllers so far
for testing purposes.

Alan

