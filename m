Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267047AbSK2OD6>; Fri, 29 Nov 2002 09:03:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267048AbSK2OD6>; Fri, 29 Nov 2002 09:03:58 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:8089 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267047AbSK2OD6>; Fri, 29 Nov 2002 09:03:58 -0500
Subject: Re: Asus P4B533 and resource conflict on IDE (P4PE also)
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Ian Morgan <imorgan@webcon.net>
Cc: Alain Tesio <alain@onesite.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.50.0211282256120.2289-100000@light.webcon.net>
References: <20021129014416.54940079.alain@onesite.org> 
	<Pine.LNX.4.50.0211282256120.2289-100000@light.webcon.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 29 Nov 2002 14:43:37 +0000
Message-Id: <1038581017.13625.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-11-29 at 04:09, Ian Morgan wrote:
> The ICH4 IDE on my ASUS P4PE had the exact same problem, but the -ac pathes
> make it hum along very nicely. Requring the PIIX driver, though, seems a
> little wonky. Without -ac, the controller is detected as "ICH4" and doesn't
> work. With the -ac patches, it works, but is detected as PIIX. Rather
> confusing. Perhaps the the Configure.help should mention the ICH4?

Just a labelling difference. ICH4 is the chipset, it contains a PIIX IDE
controller


