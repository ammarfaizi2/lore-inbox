Return-Path: <linux-kernel-owner+willy=40w.ods.org-S967150AbWKYTqu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967150AbWKYTqu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Nov 2006 14:46:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967149AbWKYTqu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Nov 2006 14:46:50 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:19936 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S967150AbWKYTqt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Nov 2006 14:46:49 -0500
Date: Sat, 25 Nov 2006 20:47:13 +0100
From: DervishD <lkml@dervishd.net>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: usb-storage data errors
Message-ID: <20061125194713.GB30460@DervishD>
Mail-Followup-To: Jan Engelhardt <jengelh@linux01.gwdg.de>,
	Linux-kernel <linux-kernel@vger.kernel.org>
References: <20061122105322.GA17351@DervishD> <Pine.LNX.4.61.0611231908090.8427@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.61.0611231908090.8427@yvahk01.tjqt.qr>
User-Agent: Mutt/1.4.2.2i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Jan :)

 * Jan Engelhardt <jengelh@linux01.gwdg.de> dixit:
> On Nov 22 2006 11:53, DervishD wrote:
> >    - Two different usb-storage adapters (an external USB box from an
> >      unknown manufacturer and Conceptronic CIDE23U). Both are
> >      USB-to-IDE adapters.
> >
> >    In addition to this, from time to time the usb-storage adapters
> >(any of them, with any of the USB cards and any kernel) report a read
> >error, telling that some sector could not be read. This is false
> >because if I repeat the operation, the sector is correctly retrieved.
> >This can be related to some kind of timing problem, I don't know.
> 
> Try with some real USB storage device instead of a USB-to-IDE converter.

    I did a couple of tests using a Kingstong Traveller USB key, with
same results. I'm retesting with a rather shorter cable. I'll post
here the results if the error doesn't dissappear. By now, no errors
with the short cable.

    Thanks for the suggestion, Jan :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
