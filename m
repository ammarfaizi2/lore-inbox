Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262355AbVFIOcU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262355AbVFIOcU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Jun 2005 10:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262388AbVFIOcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Jun 2005 10:32:20 -0400
Received: from linuxwireless.org.ve.carpathiahost.net ([66.117.45.234]:17880
	"EHLO linuxwireless.org.ve.carpathiahost.net") by vger.kernel.org
	with ESMTP id S262355AbVFIOcP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Jun 2005 10:32:15 -0400
Reply-To: <abonilla@linuxwireless.org>
From: "Alejandro Bonilla" <abonilla@linuxwireless.org>
To: "'Denis Vlasenko'" <vda@ilport.com.ua>, "'Pavel Machek'" <pavel@ucw.cz>,
       "'Jeff Garzik'" <jgarzik@pobox.com>,
       "'Netdev list'" <netdev@oss.sgi.com>,
       "'kernel list'" <linux-kernel@vger.kernel.org>,
       "'James P. Ketrenos'" <ipw2100-admin@linux.intel.com>
Subject: RE: ipw2100: firmware problem
Date: Thu, 9 Jun 2005 08:31:51 -0600
Message-ID: <002a01c56cff$fb64ba70$600cc60a@amer.sykes.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.6604 (9.0.2911.0)
In-Reply-To: <200506090909.55889.vda@ilport.com.ua>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> What is so nice about this? That Linux novice user with his new lappie
> will join a neighbor's network every time he powers up the lappie,
> even without knowing that?
>
> That will be analogous to me plugging ethernet cable into the
> switch and
> wanting it to work, without any IP addr config, even without
> DHCP client.
> Just power up the box (or modprobe an eth module) and it
> works! Cool, eh?
>

You want things one way, I like them in another way. Whoever makes this
decision should just know that we would like to have an option to make it
load with or without the ASSOC on.

James already said to use the options ipw2100 disable=1 if you don't want it
to associate everytime on boot.

At the end, who decides this?

.Alejandro


> For some reason, we do not do this for wired nets. Why should wireless
> be different?
> --
> vda
>

