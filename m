Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265899AbUAKPT3 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 10:19:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265902AbUAKPT3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 10:19:29 -0500
Received: from moutng.kundenserver.de ([212.227.126.185]:35320 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265899AbUAKPT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 10:19:26 -0500
Date: Sun, 11 Jan 2004 16:06:58 +0100 (CET)
From: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter@peterpall.de>
Reply-To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
To: Peter Berg Larsen <pebl@math.ku.dk>
cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch).
In-Reply-To: <Pine.LNX.4.40.0401111347320.16947-100000@shannon.math.ku.dk>
Message-ID: <Pine.LNX.4.53.0401111602130.944@calcula.uni-erlangen.de>
References: <Pine.LNX.4.40.0401111347320.16947-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Provags-ID: kundenserver.de abuse@kundenserver.de auth:6f0b4d165b4faec4675b8267e0f72da4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ca. 1--70 times/min, most of the times ca. 5 times/min, but sometimes
more than one per second for hours or so... Don't find any pattern behind
it.

	Gunter.

On Today, Peter Berg Larsen wrote:

>From: Peter Berg Larsen <pebl@math.ku.dk>
>Date: Sun, 11 Jan 2004 13:52:46 +0100 (CET)
>To: Gunter Königsmann <gunter.koenigsmann@gmx.de>
>Delivered-To: GMX delivery to gunter.koenigsmann@gmx.de
>Cc: Vojtech Pavlik <vojtech@suse.cz>, linux-kernel@vger.kernel.org
>Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
>    loss (With Patch).
>
>
>On Sun, 11 Jan 2004, Gunter Königsmann wrote:
>
>> Hmmm... Now I get an "Reverted to legacy aux mode" after about every third
>> resync of the driver, and sometimes odd and sometimes even numbers of sync
>> losses...
>
>How often is that? X/minute. I do not expect many "reverted .." messages,
>but if there is, then I believe the mux ver 1.1 has added some extra error
>codes that we se as a revert.
>
>Peter
>
>
>

-- 
Cocaine is nature's way of telling you you have too much money.
		-- fortune(6)
