Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261600AbVAGU45@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261600AbVAGU45 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 15:56:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261602AbVAGUz4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 15:55:56 -0500
Received: from pop.gmx.net ([213.165.64.20]:12685 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261557AbVAGUyy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 15:54:54 -0500
X-Authenticated: #23921511
Message-ID: <41DEF6D0.2030708@gmx.de>
Date: Fri, 07 Jan 2005 21:53:36 +0100
From: "prem.de.ms" <prem.de.ms@gmx.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, kraxel@bytesex.org
Subject: Annoying cx88 messages
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[...]
cx88[0]/0: AUD_STATUS: 0x4e66 [mono/pilot c1] ctl=A2_AUTO_STEREO
cx88[0]/0: AUD_STATUS: 0x4eba [mono/pilot c2] ctl=A2_AUTO_STEREO
cx88[0]/0: AUD_STATUS: 0x4eb2 [mono/no pilot] ctl=A2_AUTO_STEREO
cx88[0]/0: AUD_STATUS: 0x4ee6 [mono/pilot c1] ctl=A2_AUTO_STEREO
[... and every second another message like this in every console and 
/var/log/dmesg]

Is there a patch for this?
I can provide more informantion, just ask.
