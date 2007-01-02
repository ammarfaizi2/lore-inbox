Return-Path: <linux-kernel-owner+w=401wt.eu-S1753691AbXABUdO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753691AbXABUdO (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 15:33:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753693AbXABUdO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 15:33:14 -0500
Received: from www17.your-server.de ([213.133.104.17]:1061 "EHLO
	www17.your-server.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753692AbXABUdN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 15:33:13 -0500
Message-ID: <459AC146.9020804@m3y3r.de>
Date: Tue, 02 Jan 2007 21:32:06 +0100
From: Thomas Meyer <thomas@m3y3r.de>
User-Agent: Thunderbird 1.5.0.9 (X11/20061222)
MIME-Version: 1.0
To: Len Brown <lenb@kernel.org>
CC: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
Subject: Re: ACPI: EC: evaluating _Q10
References: <45992109.9050009@m3y3r.de> <200701021205.07817.lenb@kernel.org>
In-Reply-To: <200701021205.07817.lenb@kernel.org>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: thomas@m3y3r.de
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown schrieb:
> The bigger question is why you get "tons of these" --
> as EC  events are usually infrequent.
> Do you have a big number next to "acpi" in /proc/interrupts?
> If so, at what rate is it growing?
>
> thanks,
> -Len

maybe tons were a bit to overstated... After a fresh reboot, i count 110 
_q10 and one _q21messages now with 8 min. uptime and around 10300 acpi 
interrupts.


