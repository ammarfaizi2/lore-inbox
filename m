Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264208AbTFDW0D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 18:26:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264231AbTFDW0D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 18:26:03 -0400
Received: from jma24.plus.com ([212.159.46.210]:53846 "EHLO lion")
	by vger.kernel.org with ESMTP id S264208AbTFDWZy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 18:25:54 -0400
From: "John Appleby" <john@dnsworld.co.uk>
To: "'Russell King'" <rmk@arm.linux.org.uk>, "John Appleby" <johna@unickz.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Serio keyboard issues 2.5.70
Date: Wed, 4 Jun 2003 23:44:17 +0100
Message-ID: <434747C01D5AC443809D5FC540501131569A@bobcat.unickz.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2616
In-Reply-To: <434747C01D5AC443809D5FC5405011310970EA@bobcat.unickz.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > and I get nothing past "add_tail". I'd expect it to recognize my dev
and
> > attempt to connect to it.
> 
> Do you drop out the bottom of the function?  If you have no hardware
ports
> registered, I'd expect this to be the case.

Yeah; I thought though what I was doing was registering the port.

I'm clearly missing something really obvious here. Are you saying that I
should have registered the port somewhere else?

Sorry for the dumb questions but there's no serio documentation yet hit
the tree, I presume as it's pretty new for non-USB devices.

Regards,

John


