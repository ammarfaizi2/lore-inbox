Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964940AbWIKXJa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964940AbWIKXJa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932325AbWIKXJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:09:30 -0400
Received: from shawidc-mo1.cg.shawcable.net ([24.71.223.10]:24876 "EHLO
	pd2mo1so.prod.shaw.ca") by vger.kernel.org with ESMTP
	id S932154AbWIKXJ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:09:29 -0400
Date: Mon, 11 Sep 2006 17:09:26 -0600
From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: libata sr0 not automounted
In-reply-to: <fa.7gZw9Gn28jSX64uX08TdgkXPdUI@ifi.uio.no>
To: =?ISO-8859-1?Q?=22J=2EA=2E_Magall=F3n=22?= <jamagallon@ono.com>
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Message-id: <4505ECA6.20207@shaw.ca>
MIME-version: 1.0
Content-type: text/plain; charset=ISO-8859-1; format=flowed
Content-transfer-encoding: 8BIT
References: <fa.7gZw9Gn28jSX64uX08TdgkXPdUI@ifi.uio.no>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallón wrote:
> Hi...
> 
> My 2 ATA cd-roms, drived with libata, are not auto-mounted in gnome.
> How can I debug this ?
> Can I se if the kernel sends the correct events ?

Probably the same problem I've seen, a bug in hal. See:

https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=201533

-- 
Robert Hancock      Saskatoon, SK, Canada
To email, remove "nospam" from hancockr@nospamshaw.ca
Home Page: http://www.roberthancock.com/

