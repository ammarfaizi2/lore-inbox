Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261347AbUEVOEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261347AbUEVOEF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 10:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUEVOEF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 10:04:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:51892 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261347AbUEVOED (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 10:04:03 -0400
X-Authenticated: #199736
Date: Sat, 22 May 2004 16:04:00 +0200
From: Corin Langosch <corinl@gmx.de>
Reply-To: Corin Langosch <corinl@gmx.de>
X-Priority: 3 (Normal)
Message-ID: <855033567.20040522160400@gmx.de>
To: linux-kernel@vger.kernel.org
Subject: compiling for dual opteron
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i'm running debian testing on a dual 246 opteron here.

i already successfully compiled the kernel myself and
set the cpu-type to "Opteron" using menuconfig.
i wonder how i could enable additional switches like
"-o3 -sse -sse2 -m64" etc..or isnt' this usefull at
full?

thanks,
Corin


