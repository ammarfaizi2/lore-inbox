Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266051AbTFWOE5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jun 2003 10:04:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266052AbTFWOE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jun 2003 10:04:56 -0400
Received: from mail.ithnet.com ([217.64.64.8]:17681 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S266051AbTFWOEz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jun 2003 10:04:55 -0400
Date: Mon, 23 Jun 2003 16:19:32 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Broadcom bcm 4401
Message-Id: <20030623161932.476ed9f0.skraw@ithnet.com>
In-Reply-To: <1056377068.13529.41.camel@dhcp22.swansea.linux.org.uk>
References: <20030623151040.135133f9.skraw@ithnet.com>
	<1056377068.13529.41.camel@dhcp22.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 23 Jun 2003 15:04:29 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Llu, 2003-06-23 at 14:10, Stephan von Krawczynski wrote:
> > Hello all,
> > 
> > does anybody know what drivers are available for BCM4401 network cards? Are
> > they somehow compatible to whatever?
> 
> There is a broadcom b44 driver in -ac, but it needs a lot more cleaning
> up or rewriting before it goes anywhere further

Thanks for your hint, I will try. If you need test input, feel free to ask. The
device seems widespread for built-in network cards, seems like Acer uses it
quite seriously in the Travelmate series, but googling around shows all kinds
of boards using it.

Regards,
Stephan
