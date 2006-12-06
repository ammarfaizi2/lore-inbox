Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937645AbWLFVLe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937645AbWLFVLe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Dec 2006 16:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937647AbWLFVLe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Dec 2006 16:11:34 -0500
Received: from tmailer.gwdg.de ([134.76.10.23]:54795 "EHLO tmailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937645AbWLFVLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Dec 2006 16:11:33 -0500
Date: Wed, 6 Dec 2006 22:10:11 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Norbert Kiesel <nkiesel@tbdnetworks.com>
cc: Arjan van de Ven <arjan@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: Why is "Memory split" Kconfig option only for EMBEDDED?
In-Reply-To: <Pine.LNX.4.61.0612062158010.16042@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0612062209180.16042@yvahk01.tjqt.qr>
References: <1165405350.5954.213.camel@titan.tbdnetworks.com> 
 <1165406299.3233.436.camel@laptopd505.fenrus.org> 
 <1165407548.5954.224.camel@titan.tbdnetworks.com> 
 <1165409112.3233.441.camel@laptopd505.fenrus.org>
 <1165412195.5954.239.camel@titan.tbdnetworks.com>
 <Pine.LNX.4.61.0612062158010.16042@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 6 2006 22:00, Jan Engelhardt wrote:
>
>I have not had yet any problems with VMSPLIT_3G_OPT ever since I
>used it -- which dates back to when it was a feature of Con
>Kolivas's patchset (known as LOWMEM1G), [even] before it got
>merged in mainline.

(Excluding the cases Adrian Bunk listed: WINE, which I don't use, and 
also 'some Java programs' which I have not seen.)


	-`J'
-- 
