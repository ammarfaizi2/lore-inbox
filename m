Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262093AbVAEAlT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262093AbVAEAlT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 19:41:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbVAEAkz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 19:40:55 -0500
Received: from CPE-139-168-157-43.nsw.bigpond.net.au ([139.168.157.43]:20988
	"EHLO e4.eyal.emu.id.au") by vger.kernel.org with ESMTP
	id S262118AbVAEAjU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 19:39:20 -0500
Message-ID: <41DB3733.3060002@eyal.emu.id.au>
Date: Wed, 05 Jan 2005 11:39:15 +1100
From: Eyal Lebedinsky <eyal@eyal.emu.id.au>
Organization: Eyal at Home
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: list linux-kernel <linux-kernel@vger.kernel.org>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: 2.6.10-ac3 compile failure
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   CC [M]  drivers/char/agp/intel-agp.o
drivers/char/agp/intel-agp.c: In function `intel_i915_configure':
drivers/char/agp/intel-agp.c:640: error: too many arguments to function `writel'
make[3]: *** [drivers/char/agp/intel-agp.o] Error 1

FYI

-- 
Eyal Lebedinsky (eyal@eyal.emu.id.au) <http://samba.org/eyal/>
	If attaching .zip rename to .dat
