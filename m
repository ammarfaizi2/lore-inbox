Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbUKBTAq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUKBTAq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Nov 2004 14:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261329AbUKBTAq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Nov 2004 14:00:46 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:51398 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S261334AbUKBTAJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Nov 2004 14:00:09 -0500
Date: Tue, 2 Nov 2004 19:59:59 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Bernd Petrovitsch <bernd@firmix.at>
cc: =?iso-8859-2?Q?Pawe=B3?= Sikora <pluto@pld-linux.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [oops] lib/vsprintf.c
In-Reply-To: <1099421176.10957.3.camel@tara.firmix.at>
Message-ID: <Pine.LNX.4.53.0411021958580.9722@yvahk01.tjqt.qr>
References: <200411020719.55570.pluto@pld-linux.org> 
 <Pine.LNX.4.53.0411020802410.13921@yvahk01.tjqt.qr>  <200411021934.38802.pluto@pld-linux.org>
 <1099421176.10957.3.camel@tara.firmix.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Yes, I known. I did it intentionally.
>> IMHO kernel should be more resistant to accidental programmers errors.
>> Be secure, trust no one ;)
>
>ACK. Therefore the kernel oopses, rendering the machine useless for the
>moment and forces the programmer to look for the bug.

And thanks to the "stupidity" of the >> poster, the Debian Group found out that
their box was h4x0r3d when the machine oopsed repeatedly. :-)



Jan Engelhardt
-- 
Gesellschaft für Wissenschaftliche Datenverarbeitung
Am Fassberg, 37077 Göttingen, www.gwdg.de
