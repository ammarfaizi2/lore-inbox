Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129609AbRCCROi>; Sat, 3 Mar 2001 12:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129613AbRCCRO2>; Sat, 3 Mar 2001 12:14:28 -0500
Received: from imladris.demon.co.uk ([193.237.130.41]:32007 "EHLO
	imladris.demon.co.uk") by vger.kernel.org with ESMTP
	id <S129609AbRCCROR>; Sat, 3 Mar 2001 12:14:17 -0500
Date: Sat, 3 Mar 2001 17:14:01 +0000 (GMT)
From: David Woodhouse <dwmw2@infradead.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: David Priban <david2@maincube.net>, <linux-kernel@vger.kernel.org>
Subject: Re: i2o & Promise SuperTrak100
In-Reply-To: <E14YGAz-0006k8-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.30.0103031710220.6520-100000@imladris.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 28 Feb 2001, Alan Cox wrote:

> Umm that sounds like it might be timing. That could be a pain

Timing-related problems in code using sleep_on(). Film at 11. :)

-- 
dwmw2


