Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932825AbWF2VoL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932825AbWF2VoL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:44:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932921AbWF2VoK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:44:10 -0400
Received: from mx.pathscale.com ([64.160.42.68]:27023 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S932825AbWF2VoI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:44:08 -0400
Content-Type: multipart/mixed; boundary="===============1089688466=="
MIME-Version: 1.0
Subject: [PATCH 0 of 39] ipath - bug fixes, performance enhancements,
	and portability improvements
Message-Id: <patchbomb.1151617251@eng-12.pathscale.com>
Date: Thu, 29 Jun 2006 14:40:51 -0700
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: akpm@osdl.org, rdreier@cisco.com, mst@mellanox.co.il
Cc: openib-general@openib.org, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--===============1089688466==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

Hi, Andrew -

These patches bring the ipath driver up to date with a number of bug fixes,
performance improvements, and better PowerPC support.  There are a few
whitespace and formatting patches in the series, but they're all self-
contained.  The patches have been tested internally, and shouldn't contain
anything controversial.

My hope is that they'll sit in -mm for a little bit, and make it into
an early 2.6.18 -rc kernel.

Thanks,

	<b

--===============1089688466==--
