Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263138AbTDMDep (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:34:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263139AbTDMDep (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:34:45 -0400
Received: from tomts21.bellnexxia.net ([209.226.175.183]:25803 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S263138AbTDMDep (for <rfc822;linux-kernel@vger.kernel.org>); Sat, 12 Apr 2003 23:34:45 -0400
Subject: Re: 2.5.67-mm2
From: Shane Shrybman <shrybman@sympatico.ca>
To: Andrew Morton <akpm@digeo.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Organization: 
Message-Id: <1050205590.2158.5.camel@mars.goatskin.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 12 Apr 2003 23:46:30 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The boot hang just after the  'ok, booting the kernel message' with
2.5.67-mm2 is reproducible and the problem is not seen with just 2.5.67
and the linus.patch. I also took a wild guess and tried backing out
bootmem-speedup.patch and mem_map-init-arch-hooks.patch but that didn't
help either.

shane

