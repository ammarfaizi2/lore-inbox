Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265842AbUAVJ7n (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 04:59:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266150AbUAVJ7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 04:59:43 -0500
Received: from [212.239.225.82] ([212.239.225.82]:46725 "EHLO
	precious.kicks-ass.org") by vger.kernel.org with ESMTP
	id S265842AbUAVJ7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 04:59:42 -0500
From: Jan De Luyck <lkml@kcore.org>
To: linux-kernel@vger.kernel.org
Subject: MD Raid compatability between 2.4/2.6
Date: Thu, 22 Jan 2004 10:59:39 +0100
User-Agent: KMail/1.5.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401221059.39223.lkml@kcore.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello List,

Just wondering: is an md mirror setup under 2.6 compatible with 2.4? 
Basically: I want to downgrade a machine currently running 2.6.0 to 2.4.24, 
but it's setup with a mirror raid that I don't really want to bother setting 
up again.

Jan
-- 
Insanity is considered a ground for divorce, though by the very same
token it is the shortest detour to marriage.
		-- Wilson Mizner

