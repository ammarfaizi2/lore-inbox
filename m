Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264924AbTFLRth (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jun 2003 13:49:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264925AbTFLRth
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jun 2003 13:49:37 -0400
Received: from Mail1.kontent.de ([81.88.34.36]:26793 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S264924AbTFLRtg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jun 2003 13:49:36 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Michel Alexandre Salim <mas118@york.ac.uk>, linux-kernel@vger.kernel.org
Subject: Re: Broken USB, sound in 2.5.70-mmX series
Date: Thu, 12 Jun 2003 20:02:55 +0200
User-Agent: KMail/1.5.1
References: <1055436599.6845.7.camel@bushido> <1055437375.6143.2.camel@bushido>
In-Reply-To: <1055437375.6143.2.camel@bushido>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200306122002.55017.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> It is definitely ACPI - I tried booting with ACPI off, everything works
> (sound stutters though). Booting with ACPI, the sound driver is not
> loaded. Manually loading, sound stuttered then stopped after one second.
> Keyboard and mouse (both USB) do not work with ACPI even though the
> drivers are loaded.

Do you see irqs for USB if you boot with acpi?

	Regards
		Oliver

