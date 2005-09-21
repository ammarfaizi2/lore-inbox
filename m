Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751362AbVIUSgZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751362AbVIUSgZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Sep 2005 14:36:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751366AbVIUSgZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Sep 2005 14:36:25 -0400
Received: from smtp-103-wednesday.nerim.net ([62.4.16.103]:38413 "EHLO
	kraid.nerim.net") by vger.kernel.org with ESMTP id S1751362AbVIUSgY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Sep 2005 14:36:24 -0400
Date: Wed, 21 Sep 2005 20:37:37 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Anton Altaparmakov <aia21@cam.ac.uk>
Cc: kronos@kronoz.cjb.net, linux-kernel@vger.kernel.org,
       Bas Vermeulen <bvermeul@blackstar.nl>
Subject: Re: 2.6.14-rc1 - kernel BUG at fs/ntfs/aops.c:403
Message-Id: <20050921203737.5a82ba60.khali@linux-fr.org>
In-Reply-To: <1127122747.493.5.camel@imp.csi.cam.ac.uk>
References: <20050917145150.GA5481@dreamland.darkstar.lan>
	<1127122747.493.5.camel@imp.csi.cam.ac.uk>
X-Mailer: Sylpheed version 2.0.1 (GTK+ 2.6.1; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anton,

> Below is the fix I just sent off to Linus.

2.6.14-rc2 works for me.

Thanks,
-- 
Jean Delvare
