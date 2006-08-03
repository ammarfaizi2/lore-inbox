Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWHCCjB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWHCCjB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 22:39:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751378AbWHCCjB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 22:39:01 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:4414 "EHLO
	pd4mo3so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S1751374AbWHCCjA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 22:39:00 -0400
Date: Wed, 02 Aug 2006 20:37:55 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: [2.6.18-rc2-mm1] libata cdroms not automounted
In-reply-to: <fa.0fapZpsbPNwCajbQ53nT7FIKF1k@ifi.uio.no>
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Message-id: <44D16183.1040603@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <fa.0fapZpsbPNwCajbQ53nT7FIKF1k@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallón wrote:
> Following with my switch to libata for everything...
> After latest patches, my burner and dvd work ok, apart from the fact that
> they do not get auto-mounted in gnome environment.

I've seen this as well on my laptop with the latest Fedora Core 5 kernel 
plus Alan's 2.6.17-ide1, with the latest FC5 update versions of udev, 
hal, etc.

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

