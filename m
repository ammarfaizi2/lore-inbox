Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266308AbUBQQ2Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 11:28:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266309AbUBQQ2Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 11:28:16 -0500
Received: from main.gmane.org ([80.91.224.249]:10439 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266308AbUBQQ2P (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 11:28:15 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Moritz Muehlenhoff <jmm@informatik.uni-bremen.de>
Subject: Re: Linux 2.6.3-rc3
Date: Tue, 17 Feb 2004 17:29:17 +0100
Organization: Cocytus
Message-ID: <t3s9g1-0e1.ln1@legolas.mmuehlenhoff.de>
References: <Pine.LNX.4.58.0402141931050.14025@home.osdl.org> <m2znbk4s8j.fsf@p4.localdomain> <20040215184449.4db42542.onur@delipenguen.net> <ot57g1-db1.ln1@legolas.mmuehlenhoff.de>
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: pd9507fd7.dip.t-dialin.net
User-Agent: slrn/0.9.8.0 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Moritz Muehlenhoff wrote:
>>  The problem is, If I enter X (works fine) and go back to the console,
>> there are a few permenant color lines at the bottom. If I do "clear"
>> or enter an ncurses based app (like midnight commander) the screen is
>> garbled like interlaced.
>
> I can confirm that bug for Radeon 7500 (RV200 QW) as well. The last
> line isn't properly cleared.

This does still exist in rc4.

