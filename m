Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265515AbUAWKnU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 05:43:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265529AbUAWKnU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 05:43:20 -0500
Received: from nx5.HRZ.Uni-Dortmund.DE ([129.217.131.21]:8375 "EHLO
	nx5.hrz.uni-dortmund.de") by vger.kernel.org with ESMTP
	id S265515AbUAWKnT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 05:43:19 -0500
Date: Fri, 23 Jan 2004 11:40:18 +0100 (CET)
From: Ingo Buescher <usenet-2004@r-arcology.de>
X-X-Sender: gallatin@nathan.cybernetics.com
To: =?iso-8859-2?q?Pawe=B3_Goleniowski?= <pawelg@dabrowa.pl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rivafb & small 16 bit mode problem
In-Reply-To: <200401221430.52323.pawelg@dabrowa.pl>
Message-ID: <Pine.LNX.4.58.0401231138070.2589@anguna.ploreargvpf.pbz>
References: <20040122045458.5B2922C100@lists.samba.org> <200401221430.52323.pawelg@dabrowa.pl>
X-Binford: 6100 (more power)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Jan 2004, [iso-8859-2] Pawe? Goleniowski wrote:

> But I have no idea which options should I send to kernel to get different
> resolution (video=riva:800x600-16@85 don't work) and I have very ugly Linux
> logo while booting ;)

video=rivafb:800x600-16@85
          ^^

should work

IB
-- 
===========================================================================
Ingo Buescher <usenet-2004@r-arcology.de>
"Maneuvering with an army is advantageous; with an undisciplined
multitude, most dangerous." -- Sun Tzu
