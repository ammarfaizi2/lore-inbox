Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751560AbWJMSZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751560AbWJMSZg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Oct 2006 14:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751797AbWJMSZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Oct 2006 14:25:36 -0400
Received: from bay0-omc3-s16.bay0.hotmail.com ([65.54.246.216]:11688 "EHLO
	bay0-omc3-s16.bay0.hotmail.com") by vger.kernel.org with ESMTP
	id S1751560AbWJMSZf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Oct 2006 14:25:35 -0400
Message-ID: <BAY20-F6E52A8A576FF802B03B78D80A0@phx.gbl>
X-Originating-IP: [80.178.105.199]
X-Originating-Email: [yan_952@hotmail.com]
In-Reply-To: <1160759621.25218.68.camel@localhost.localdomain>
From: "Burman Yan" <yan_952@hotmail.com>
To: alan@lxorguk.ukuu.org.uk, davej@redhat.com
Cc: jesper.juhl@gmail.com, linux-kernel@vger.kernel.org, pazke@donpac.ru
Subject: Re: [PATCH] HP mobile data protection system driver
Date: Fri, 13 Oct 2006 20:25:31 +0200
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 13 Oct 2006 18:25:34.0428 (UTC) FILETIME=[F90A71C0:01C6EEF4]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




>From: Alan Cox <alan@lxorguk.ukuu.org.uk>
>To: Dave Jones <davej@redhat.com>
>CC: Jesper Juhl <jesper.juhl@gmail.com>, Burman Yan <yan_952@hotmail.com>,  
>       linux-kernel@vger.kernel.org, Andrey Panin <pazke@donpac.ru>
>Subject: Re: [PATCH] HP mobile data protection system driver
>Date: Fri, 13 Oct 2006 18:13:41 +0100
>
>
>Agreed. We already have an interface layer for reporting multiple
>dimensions of motion control - the joystick interface. I think we really
>ought to use that with some way to spot that its HDAPS etc so drivers
>can decide to use it for its intended purpose (eg a different device
>name scheme). The joystick compatibility would also mean it can "just
>work" if you tell games to use the device.
>
>Alan

mdps works as an input device if you choose to enable that functionality (at 
load time or at runtime).
Already had a great time playing neverball with it :)

Yan

_________________________________________________________________
Express yourself instantly with MSN Messenger! Download today it's FREE! 
http://messenger.msn.click-url.com/go/onm00200471ave/direct/01/

