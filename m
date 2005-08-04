Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261687AbVHDA52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261687AbVHDA52 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 20:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261689AbVHDAy6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 20:54:58 -0400
Received: from mta6.srv.hcvlny.cv.net ([167.206.4.201]:44119 "EHLO
	mta6.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S261716AbVHDAx4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 20:53:56 -0400
Date: Wed, 03 Aug 2005 20:53:52 -0400
From: Mathieu Chouquet-Stringer <ml2news@optonline.net>
X-Face: %JOeya=Dg!}[/#Go&*&cQ+)){p1c8}u\Fg2Q3&)kothIq|JnWoVzJtCFo~4X<uJ\9cHK'.w
 3:{EoxBR
Subject: Re: [2.6 patch] remove support for gcc < 3.2
In-reply-to: <200508022108.05391.gustavo@compunauta.com>
To: gustavo@compunauta.com (=?iso-8859-1?q?Gustavo_Guillermo_P=E9rez?=)
Cc: linux-kernel@vger.kernel.org
Message-id: <m3slxq34kf.fsf@mcs.bigip.mine.nu>
Organization: Uh?
MIME-version: 1.0
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 8BIT
References: <20050731222606.GL3608@stusta.de>
 <200508022108.05391.gustavo@compunauta.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

gustavo@compunauta.com (Gustavo Guillermo Pérez) writes:
> Please keep the 2.95 support I use to use a lot, on not new hardware.
> If you have old hardware with not much resources gcc 2.95 works just fine and 
> fast, even you build the main kernel on other machine, by compatibility 
> issues one or two drivers should be builded a lot of times into the older 
> hardware, then we are forced to build gcc 3.4 or something like.

Moreover I get some weird networking problems which prevent setting up the
routes (RNETLINK invalid argument messages) when I compile my kernel with
4.0.1 while the same kernel, same config works fine compiled with 3.2.3...

So eventhough 4.0 is supposed to be supported, it doesn't work too well in
my case.
-- 
Mathieu Chouquet-Stringer
