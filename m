Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262352AbTEUXAK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 19:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262356AbTEUXAJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 19:00:09 -0400
Received: from as5-6-5.hdn.s.bonet.se ([217.215.97.110]:36992 "EHLO
	mcojj.vger.org") by vger.kernel.org with ESMTP id S262352AbTEUXAJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 19:00:09 -0400
From: prox@vger.org
To: linux-kernel@vger.kernel.org
Subject: Question: kernel 2.4.20, mount --bind
Date: Thu, 22 May 2003 01:12:30 +0200
Message-ID: <uo1ocv4p16jpi22ndi5rhhc6r04lp7jovl@4ax.com>
X-Mailer: Forte Agent 1.8/32.548
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm wondering how many mounts can 2.4.20+ handle? And are device mounts
separated from --bind mounts or is it the same table?

How much of a preformance lost would it be to have say something like 5k
--bind mounts?

Thanks

--
echo '[q]sa[ln0=aln256%Pln256/snlbx]sb382793634903snlbx806007844
59087snlbx71765988876376snlbx11172185121099snlbx'|\dc
:prox:<prox@vger.org>:icq.18682823:www.vger.org:
:unix/linux.admin/coder:www.vger.org/cv.html:
