Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750975AbWGCIr7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbWGCIr7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Jul 2006 04:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750989AbWGCIr7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Jul 2006 04:47:59 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:30506 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1750975AbWGCIr6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Jul 2006 04:47:58 -0400
Message-ID: <44A8DACA.1000605@gentoo.org>
Date: Mon, 03 Jul 2006 09:52:26 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Daniel Bonekeeper <thehazard@gmail.com>
CC: kernelnewbies@nl.linux.org, linux-kernel@vger.kernel.org
Subject: Re: Driver for Microsoft USB Fingerprint Reader
References: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
In-Reply-To: <e1e1d5f40607022351y4af6e709n1ba886604a13656b@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Bonekeeper wrote:
> I would like to develop a driver for any kind of fingerprint reader
> that currently doesn't have a driver for linux, and I'm open for
> suggestions on which device I should use. My first thought was the
> microsoft usb fingerprint reader
> (http://www.geeks.com/details.asp?invtid=DG2-00002-DT&cpc=SCH) because
> it's a new device (and, of course, doesn't have any driver for linux),
> it's cheap, and it's from MS (read "would be fun" =)

Already done (well, in development with early working code):
http://dpfp.berlios.de

> Another question: Is there any place (probably a webpage) where we can
> see a list of hardware devices separated by category, and know if
> there's already a driver for it (and the name/url of the maintainer)
> or not, if there are plans to develop a driver for it or not, or to
> form teams to develop it ? Like a webpage where I can browse and see
> that the device X doesn't have any drivers for it (and people can go
> and "vote" for a driver, so we can know which devices are most wanted
> by users), and sign ourselves to develop it ? I think that it would be
> cool. If there isn't anything like that, I can develop it myself and
> somebody at kernel.org or another place could host it =]

For USB devices there is http://www.qbik.ch/usb/devices/

Daniel

