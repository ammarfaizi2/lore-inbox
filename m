Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTDDR2I (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 12:28:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263887AbTDDRXO (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 12:23:14 -0500
Received: from smtp01.web.de ([217.72.192.180]:34832 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S263881AbTDDRWo (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 12:22:44 -0500
From: Michael Buesch <freesoftwaredeveloper@web.de>
To: Burton Windle <bwindle@fint.org>
Subject: Re: 2.5.66-bk9 compile problem
Date: Fri, 4 Apr 2003 19:32:19 +0200
User-Agent: KMail/1.5
References: <Pine.LNX.4.43.0304041217230.1464-100000@morpheus>
In-Reply-To: <Pine.LNX.4.43.0304041217230.1464-100000@morpheus>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304041932.19272.freesoftwaredeveloper@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 04 April 2003 19:17, you wrote:
> CONFIG_I2C_SENSOR=m
>
> Set this to y and recompile.

When I set this to y and do a
make bzImage
or a
make menuconfig
it's automatically reset to m.

What's the options for CONFIG_I2C_SENSOR in menuconfig (I didn't find it).

Regards
Michael Buesch.

-- 
My homepage: http://www.8ung.at/tuxsoft
fighting for peace is like fu**ing for virginity

