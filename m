Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262368AbUJ0J7w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262368AbUJ0J7w (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 05:59:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262367AbUJ0J6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 05:58:09 -0400
Received: from mail.convergence.de ([212.227.36.84]:23197 "EHLO
	email.convergence2.de") by vger.kernel.org with ESMTP
	id S262372AbUJ0JsS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 05:48:18 -0400
Message-ID: <417F6EB2.2070807@linuxtv.org>
Date: Wed, 27 Oct 2004 11:47:30 +0200
From: Michael Hunold <hunold@linuxtv.org>
User-Agent: Mozilla Thunderbird 0.8 (X11/20040913)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][0/5] Update the DVB subsystem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

thanks for applying the recent DVB updates to 2.6.10-rc1.

Here comes another patchset with 5 patches that in short does the following:

- rework debug print logic in av7110 driver
- various fixes in the dvb-core
- one new driver named "Terratec CinergyT2/qanu" for an highspeed USB2 
DVB-T receiver
- general overhaul of the dibusb USB DVB driver -- there are more clones 
of this card out there than we expected

As usual, the details are at the top of each patch. IMO all changes are 
non-intrusive and can be applied safely.

Please apply.

CU
Michael.
