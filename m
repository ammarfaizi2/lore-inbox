Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932245AbWEAUmW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932245AbWEAUmW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 May 2006 16:42:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWEAUmW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 May 2006 16:42:22 -0400
Received: from server6.greatnet.de ([83.133.96.26]:30952 "EHLO
	server6.greatnet.de") by vger.kernel.org with ESMTP id S932245AbWEAUmU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 May 2006 16:42:20 -0400
Message-ID: <445673F0.4020607@nachtwindheim.de>
Date: Mon, 01 May 2006 22:47:44 +0200
From: Henne <henne@nachtwindheim.de>
User-Agent: Mozilla Thunderbird 1.0.8 (X11/20060411)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: arjan@infradead.org
Cc: linux-kernel@vger.kernel.org, tiwai@suse.de, greg@kroah.org
Subject: Re: [ALSA] add __devinitdata to all pci_device_id
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 01, 2006 at 06:49:24PM +0200, Arjan van de Ven wrote:

 > are you really really sure you want to do this?
 > These structures are exported via sysfs for example, I would think this
 > is quite the wrong thing to make go away silently...

Hi there!

Sorry if I didn't mention everything I was .
A couple of devices had __devinitdata on their tables like written in Documentation/pci.txt,
so I thought this is something that was forgotten.
How can we get clearness in that topic?

Greets,
Henrik
