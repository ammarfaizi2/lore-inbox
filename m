Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVBMQNV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVBMQNV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Feb 2005 11:13:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVBMQNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Feb 2005 11:13:21 -0500
Received: from smtp-100-sunday.nerim.net ([62.4.16.100]:63502 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261284AbVBMQNE convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Feb 2005 11:13:04 -0500
Date: Sun, 13 Feb 2005 17:13:24 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Enrico Bartky <DOSProfi@web.de>
Cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.11-rc4
Message-Id: <20050213171324.47368e77.khali@linux-fr.org>
In-Reply-To: <420F4F65.2080701@web.de>
References: <Pine.LNX.4.58.0502121928590.19649@ppc970.osdl.org>
	<420F4F65.2080701@web.de>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Enrico,

> It is possible to include the SIS5595 chip driver to the final
> release?

No, sorry. It's not even in -mm yet (in fact it's even not in Greg's
bk-i2c tree yet). It needs to spend some time (and get some testing) in
-mm before it can go to Linus.

You are still welcome to get the patch [1] and apply it manually to your
tree if you want support right now. And of course, report to the
Aurélien and the sensors mailing-list if you hit a problem.

[1] http://lkml.org/lkml/diff/2005/2/6/192/1

Thanks,
-- 
Jean Delvare
