Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263084AbUDMJTa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 05:19:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263304AbUDMJTa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 05:19:30 -0400
Received: from [62.241.33.80] ([62.241.33.80]:55056 "EHLO
	mx00.linux-systeme.com") by vger.kernel.org with ESMTP
	id S263084AbUDMJT1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 05:19:27 -0400
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
Organization: Working Overloaded Linux Kernel
To: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm5 devpts filesystem doesn't work
Date: Tue, 13 Apr 2004 11:19:05 +0200
User-Agent: KMail/1.6.1
Cc: Andrew Morton <akpm@osdl.org>, helgehaf@aitel.hist.no
References: <20040412221717.782a4b97.akpm@osdl.org> <20040413011133.2d15a4d6.akpm@osdl.org> <20040413013942.181cb2b5.akpm@osdl.org>
In-Reply-To: <20040413013942.181cb2b5.akpm@osdl.org>
X-Operating-System: Linux 2.6.4-wolk2.3 i686 GNU/Linux
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200404131119.05338@WOLK>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 13 April 2004 10:39, Andrew Morton wrote:

Hi Andrew,

> yes, that patch is bust.  And rwsem-scale.patch is oopsing all over the
> place.  Ho hum.
> I've trashed 2.6.5-mm5 and am uploading 2.6.5-mm5-1, same place.

where is the announce? Just wondering why at least these:

- devinet-ctl_table-fix.patch
- ipmi-socket-interface.patch

are missing?

ciao, Marc
