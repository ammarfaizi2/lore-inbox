Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262354AbVBXS1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262354AbVBXS1z (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 13:27:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262450AbVBXSYU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 13:24:20 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:38057 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262449AbVBXSXw
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 13:23:52 -0500
Message-ID: <421E1BB1.4090303@tiscali.de>
Date: Thu, 24 Feb 2005 19:23:45 +0100
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Lukas Hejtmanek <xhejtman@mail.muni.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: USB 2.0 Mass storage device
References: <20050224175918.GA7627@mail.muni.cz>
In-Reply-To: <20050224175918.GA7627@mail.muni.cz>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lukas Hejtmanek wrote:

>Hello,
>
>I have a new MSI Mega Stick 511 USB 2.0 Mass storage device. In my laptop I have
>USB 2.0 port (Acer TM242), when I connect device, only uhci_hcd driver detect
>device. Does anyone have some suggestions? Thanks.
>
>  
>
Hi!
Is hotplug enabled (it should detect it as a scsi generic mass storage)?

Matthias-Christian Ott
