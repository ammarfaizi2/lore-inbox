Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbTFKQT6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 12:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262645AbTFKQT6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 12:19:58 -0400
Received: from uni-paderborn.de ([131.234.22.30]:63122 "EHLO mail-gate")
	by vger.kernel.org with ESMTP id S262589AbTFKQT5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 12:19:57 -0400
Message-ID: <3EE75968.F789F33C@upb.de>
Date: Wed, 11 Jun 2003 18:31:36 +0200
From: Kay Salzwedel <nkz@upb.de>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: buffer requests served by cache
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'd like to know the amount of requests to block devices that are served
by the cache instead of a read/write to the device itself. Can anybody
point my code where the kernel distinguishes between the two?

Thanks for yur help.

Regards KAy
-- 
--------------------------------------------------------------------
Kay A Salzwedel

Heinz Nixdorf Institute
University of Paderborn
Germany
------------------------------------------
E-Mail:  kay@hni.uni-paderborn.de
Tel.:    +49-5251-60 64 58
--------------------------------------------------------------------
