Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261522AbTLIKkN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 05:40:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262114AbTLIKkN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 05:40:13 -0500
Received: from sauerland-ev.de ([217.160.171.150]:63113 "EHLO
	gomorrah.sauerland.de") by vger.kernel.org with ESMTP
	id S261522AbTLIKkI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 05:40:08 -0500
To: gene.heskett@verizon.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: sensors vs 2.6
References: <200312090258.01944.gene.heskett@verizon.net>
X-Now-Playing: Angizia - Die Notiz Von Mutter Wohlgestoalt. Es Starb Eine
	Eintragung Am 16. Oktober
Date: Tue, 09 Dec 2003 11:33:03 +0100
In-Reply-To: <200312090258.01944.gene.heskett@verizon.net> (Gene Heskett's
	message of "Tue, 9 Dec 2003 02:58:01 -0500")
Message-ID: <m3zne21dsw.fsf@toyland.sauerland.de>
User-Agent: Gnus/5.1003 (Gnus v5.10.3) XEmacs/21.5 (celeriac, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Sebastian Kaps <seb-keyword-linux.637a6e@toyland.sauerland.de>
X-Delivery-Agent: TMDA/0.84 (Tim Tam)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gene!

On Tue, 9 Dec 2003 02:58:01 -0500 you wrote:

> kernel, 2.6.0-test11, and have dilligently searched the /proc and 
> /sys directories, and seem to have come up blank.

I have configured "I2C support", "I2C device interface", "Intel PIIX4"
and "Winbond ...". I get all sensor readings in /sys/bus/i2c/devices/*,
e.g.:
,----
| # cat /sys/bus/i2c/devices/0-002d/fan_input1 
| 5400
`----

-- 
Ciao, Sebastian
