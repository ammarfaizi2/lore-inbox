Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264189AbTJOT3L (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Oct 2003 15:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264190AbTJOT3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Oct 2003 15:29:11 -0400
Received: from richardson.uni2.net ([130.227.52.104]:5018 "EHLO
	richardson.uni2.net") by vger.kernel.org with ESMTP id S264189AbTJOT3C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Oct 2003 15:29:02 -0400
Date: Wed, 15 Oct 2003 21:30:13 +0200
From: Atte =?ISO-8859-1?Q?Andr=E9?= Jensen <atte@ballbreaker.dk>
To: linux-kernel@vger.kernel.org
Subject: orinoco wireless pcmcia driver in test5
Message-Id: <20031015213013.5244bb4c.atte@ballbreaker.dk>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; i386-pc-linux-gnu)
X-Face: L)f+i9!Dd&?Kp0mK"X:JK~)"&w]slO5Hvz;j35_=8Ry!{';~cG?!m=7/OM'9lyAPa=\*pH~
 |93u]Ze?mxx9v3u615xqSkL"1C)z#kWUW,d8p,Fr[9xHza(k4{[|o{I'|EhP1MB=pkMSNf'4myHm!x
 rB|hf`h)m<vKj9H4>"=Q0Z-t*OiAS[_MZKI+/ztKNXI.QDk]m8LaI.
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

What is the result (and purpose) of no mention of the orinoco wireless
drivers in the .config for test5?

[atte@aarhus atte]$ grep -i orinoco /usr/src/linux-2.6.0-test5/.config
[atte@aarhus atte]$ 

Will the driver be linked in anyhow? If not is there a fix?

-- 
peace, love & harmony
Atte
