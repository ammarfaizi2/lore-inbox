Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbUBVNox (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 08:44:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261260AbUBVNow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 08:44:52 -0500
Received: from moutng.kundenserver.de ([212.227.126.183]:29139 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S261250AbUBVNot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 08:44:49 -0500
Message-ID: <4038B244.2020209@t-st.org>
Date: Sun, 22 Feb 2004 14:44:36 +0100
From: Tillmann Steinbrecher <t-st@t-st.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de-DE; rv:1.6b) Gecko/20031205 Thunderbird/0.4
X-Accept-Language: de-de, de-at, de, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: PROBLEM: 2.6.3 + external firewire dvd writer - frequent freezes
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:440c24a95efadc9d8e1374cf9e681760
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm using an external FireWire DVD writer (Plextor 708 in case w/Oxford
911 chipset). This was working fine until kernel 2.6.2.

Since I upgraded to 2.6.3, it frequently happens that the system totally
freezes when trying to write a DVD. It's really a hard crash, no mouse
movement, no ping on the network. Reset required.

It doesn't happen each time I try to burn a DVD, but in about 20% the
cases. So basically the writer is unusable with 2.6.3.

I searched the web and archives for the problem, but didn't find any
results, except for one guy describing the same problem, also with
2.6.3, also on this mailing list here:
http://www.ussg.iu.edu/hypermail/linux/kernel/0402.2/0950.html

However he didn't get any replies.

Please CC: me for replies, or if anybody needs .config, lspci, or other
info. The firewire controller is a Texas Instruments TSB43AB22/A.

bye & thanks for your time,
Tillmann
