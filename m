Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263932AbUE3OEa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263932AbUE3OEa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 May 2004 10:04:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbUE3OEa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 May 2004 10:04:30 -0400
Received: from twilight.ucw.cz ([81.30.235.3]:60289 "EHLO midnight.ucw.cz")
	by vger.kernel.org with ESMTP id S263932AbUE3OEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 May 2004 10:04:24 -0400
Date: Sun, 30 May 2004 16:04:46 +0200
From: Vojtech Pavlik <vojtech@suse.cz>
To: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i8042_shutdown bug: Linux 2.6.7-rc2
Message-ID: <20040530140446.GB2053@ucw.cz>
References: <xb7zn7q81fe.fsf@savona.informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xb7zn7q81fe.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 30, 2004 at 03:55:17PM +0200, Sau Dan Lee wrote:

> This bug is still in 2.6.7-rc2:
> 
>         See: http://lkml.org/lkml/2004/5/10/63
 
Yes, my tree wasn't yet merged into mainline, as I'm fixing locking in
atkbd and psmouse now. 

-- 
Vojtech Pavlik
SuSE Labs, SuSE CR
