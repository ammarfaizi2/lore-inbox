Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261188AbULRQCt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261188AbULRQCt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 11:02:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261160AbULRQCs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 11:02:48 -0500
Received: from host-3.tebibyte16-2.demon.nl ([82.161.9.107]:10003 "EHLO
	doc.tebibyte.org") by vger.kernel.org with ESMTP id S261188AbULRQBl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 11:01:41 -0500
Message-ID: <41C45463.9060502@tebibyte.org>
Date: Sat, 18 Dec 2004 17:01:39 +0100
From: Chris Ross <chris@tebibyte.org>
Organization: At home (Eindhoven, The Netherlands)
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: pt-br, pt
MIME-Version: 1.0
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.9-ac16
References: <41C2FF09.5020005@tebibyte.org><1103222616.21920.12.camel@localhost.localdomain> <1103349675.27708.39.camel@tglx.tec.linutronix.de> <41C448BB.1020902@tmr.com> <Pine.LNX.4.61.0412181606050.21338@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0412181606050.21338@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Jan Engelhardt escreveu:
> Well you can always take out your VMware and cut it down to <few RAM> MB by 
> hand, just to get an experience how "low-end" users feel.

It's not just "low-end users", my interest is in the embedded space 
where it's normal to dimension things as closely (read, cheaply) as 
possible. Random processes being killed off is not helpful, especially 
when the system hasn't actually run out of memory which is the case with 
the 2.6.9+

Regards,
Chris R.
