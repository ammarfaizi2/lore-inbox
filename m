Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265874AbUAKMxG (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 07:53:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265876AbUAKMxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 07:53:06 -0500
Received: from imf.math.ku.dk ([130.225.103.32]:51116 "EHLO imf.math.ku.dk")
	by vger.kernel.org with ESMTP id S265874AbUAKMwv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 07:52:51 -0500
Date: Sun, 11 Jan 2004 13:52:46 +0100 (CET)
From: Peter Berg Larsen <pebl@math.ku.dk>
To: =?ISO-8859-1?Q?Gunter_K=F6nigsmann?= <gunter.koenigsmann@gmx.de>
Cc: Vojtech Pavlik <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>
Subject: Re: Synaptics Touchpad workaround for strange behavior after Sync
 loss (With Patch).
In-Reply-To: <Pine.LNX.4.53.0401110935010.1395@calcula.uni-erlangen.de>
Message-ID: <Pine.LNX.4.40.0401111347320.16947-100000@shannon.math.ku.dk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Jan 2004, Gunter Königsmann wrote:

> Hmmm... Now I get an "Reverted to legacy aux mode" after about every third
> resync of the driver, and sometimes odd and sometimes even numbers of sync
> losses...

How often is that? X/minute. I do not expect many "reverted .." messages,
but if there is, then I believe the mux ver 1.1 has added some extra error
codes that we se as a revert.

Peter


