Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265372AbTLRUYB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 15:24:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265373AbTLRUYA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 15:24:00 -0500
Received: from edu.joroinen.fi ([194.89.68.130]:4525 "EHLO edu.joroinen.fi")
	by vger.kernel.org with ESMTP id S265372AbTLRUX7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 15:23:59 -0500
Date: Thu, 18 Dec 2003 22:23:57 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@iki.fi>
To: linux-kernel@vger.kernel.org
Subject: Status of NGROUPS patch?
Message-ID: <20031218202356.GY17221@edu.joroinen.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello list.

Now when 2.6.0 is released, is there any hope to get the NGROUPS patch
(which removes the hard limit of 32 groups per user) included in 2.6.x ?

We have 32 bit uid/gid's now, so it's really a shame to have so little
groups per user..

-- Pasi Kärkkäinen
       
                                   ^
                                .     .
                                 Linux
                              /    -    \
                             Choice.of.the
                           .Next.Generation.
