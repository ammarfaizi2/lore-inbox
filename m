Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVBRSip@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVBRSip (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Feb 2005 13:38:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261456AbVBRSip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Feb 2005 13:38:45 -0500
Received: from smtp-105-friday.nerim.net ([62.4.16.105]:39172 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S261436AbVBRShx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Feb 2005 13:37:53 -0500
Date: Fri, 18 Feb 2005 19:38:31 +0100
From: Jean Delvare <khali@linux-fr.org>
To: Stelian Pop <stelian@popies.net>
Cc: LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       acpi-devel@lists.sourceforge.net, Pekka Enberg <penberg@gmail.com>
Subject: Re: [PATCH, new ACPI driver] new sony_acpi driver
Message-Id: <20050218193831.3d339bbf.khali@linux-fr.org>
In-Reply-To: <20050216153924.GC4372@crusoe.alcove-fr>
References: <20050214100738.GC3233@crusoe.alcove-fr>
	<CKthPPXN.1108383209.9808960.khali@localhost>
	<20050214123822.GF3233@crusoe.alcove-fr>
	<20050214194235.073f5850.khali@linux-fr.org>
	<20050216153924.GC4372@crusoe.alcove-fr>
X-Mailer: Sylpheed version 1.0.1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stellian,

> All right, here is a third version of the driver, which adds the
> 'brightness_default' entry and rewrites a big part of the code in
> a more extensible way.

Tested, works for me (debug mode not tested).

Thanks,
-- 
Jean Delvare
