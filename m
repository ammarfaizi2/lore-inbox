Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751228AbVLLLIG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228AbVLLLIG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Dec 2005 06:08:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751229AbVLLLIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Dec 2005 06:08:06 -0500
Received: from moutvdom.kundenserver.de ([212.227.126.249]:57320 "EHLO
	moutvdomng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1751228AbVLLLIE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Dec 2005 06:08:04 -0500
Message-ID: <439D5A11.3070008@anagramm.de>
Date: Mon, 12 Dec 2005 12:08:01 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Mouse button swapping
References: <Pine.LNX.4.61.0512091508250.8080@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0512091508250.8080@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Jan!

> I produced a small patch that allows one to flip the mouse buttons at the 
> kernel level. This is useful for changing it on a per-system basis, i.e. it 
> will affect gpm, X and VMware all at once. It is changeable through
> /sys/module/mousedev/swap_buttons at runtime. Is this something mainline would
> be interested in?

Jup, sounds interesting. Maybe it would be fine to add some more documentation,
otherwise the feature might get lost in space.
I also can imagine to have free button-mapping somewhere... for multi-button
mices, configurable from right to left-handed use on the fly.

Greets,
-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19
