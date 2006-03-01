Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030193AbWCALr0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030193AbWCALr0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Mar 2006 06:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030195AbWCALr0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Mar 2006 06:47:26 -0500
Received: from khc.piap.pl ([195.187.100.11]:10756 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1030193AbWCALr0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Mar 2006 06:47:26 -0500
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: "Jon Ringle" <jringle@vertical.com>, "Greg Ungerer" <gerg@snapgear.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Linux running on a PCI Option device?
References: <43EAE4AC.6070807@snapgear.com>
	<200602281535.21974.jringle@vertical.com>
	<Pine.LNX.4.61.0602281556240.5128@chaos.analogic.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Wed, 01 Mar 2006 12:47:23 +0100
In-Reply-To: <Pine.LNX.4.61.0602281556240.5128@chaos.analogic.com> (linux-os@analogic.com's
 message of "Tue, 28 Feb 2006 16:13:06 -0500")
Message-ID: <m3slq2z8s4.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"linux-os \(Dick Johnson\)" <linux-os@analogic.com> writes:

> Usually, option boards use a PCI interface chip such as
> a PLX PCI-9656BA. It would not normally BE a PCI device
> on the Host side. The host CPU would communicate with it
> on a local bus.

Correct but IPX4xx CPU has a PCI bus interface built in (in addition
to interfaces for ROM, RAM, GPIO, Ethernet and serial).
-- 
Krzysztof Halasa
