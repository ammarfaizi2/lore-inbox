Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262720AbTFXPtg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 11:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262771AbTFXPtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 11:49:36 -0400
Received: from mail.ithnet.com ([217.64.64.8]:46596 "HELO heather.ithnet.com")
	by vger.kernel.org with SMTP id S262720AbTFXPt1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 11:49:27 -0400
Date: Tue, 24 Jun 2003 18:03:53 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jgarzik@pobox.com, linux-kernel@vger.kernel.org
Subject: Re: Broadcom bcm 4401
Message-Id: <20030624180353.1906e671.skraw@ithnet.com>
In-Reply-To: <1056469248.14611.29.camel@dhcp22.swansea.linux.org.uk>
References: <20030623151040.135133f9.skraw@ithnet.com>
	<1056377068.13529.41.camel@dhcp22.swansea.linux.org.uk>
	<3EF860A7.5000102@pobox.com>
	<1056469248.14611.29.camel@dhcp22.swansea.linux.org.uk>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 Jun 2003 16:40:49 +0100
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:

> On Maw, 2003-06-24 at 15:31, Jeff Garzik wrote:
> > 
> > What cleaning needs to be done?
> > 
> > AFAIK, I need only to fix a phy-related bug, and b44 will be working 
> > nicely.  (I have test h/w, too)
> 
> The driver I have is very windowsish, I assumne the one you have is not ?

I have tested the one from -ac2 now (2.0.0 from 25.03.03) and it works quite ok
on my laptop. I would be pleased to see it in 2.4.22 together with the acpi
stuff, sounds like a nice release for laptops ;-)

I found out SuSE uses a pretty old dated one (I guess it was 1.3.0 from
somewhen mid last year).

Regards,
Stephan
