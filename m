Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312254AbSFQPa3>; Mon, 17 Jun 2002 11:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314085AbSFQPa2>; Mon, 17 Jun 2002 11:30:28 -0400
Received: from chaos.physics.uiowa.edu ([128.255.34.189]:3792 "EHLO
	chaos.physics.uiowa.edu") by vger.kernel.org with ESMTP
	id <S312254AbSFQPa2>; Mon, 17 Jun 2002 11:30:28 -0400
Date: Mon, 17 Jun 2002 10:30:18 -0500 (CDT)
From: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
X-X-Sender: kai@chaos.physics.uiowa.edu
To: Martin Dalecki <dalecki@evision-ventures.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.22 broke modversions
In-Reply-To: <3D0DF605.8030901@evision-ventures.com>
Message-ID: <Pine.LNX.4.44.0206171029400.22308-100000@chaos.physics.uiowa.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Jun 2002, Martin Dalecki wrote:

> BTW> There is some different thing broken: TEMP files
> used by make menuconfig don't get clean up even after make distclean.

Could you be more specific? The only file I can see lying around here
is .menuconfig.log, and that gets cleaned up.

--Kai


