Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262875AbSKRSBd>; Mon, 18 Nov 2002 13:01:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262905AbSKRSBd>; Mon, 18 Nov 2002 13:01:33 -0500
Received: from fmr02.intel.com ([192.55.52.25]:54755 "EHLO
	caduceus.fm.intel.com") by vger.kernel.org with ESMTP
	id <S262875AbSKRSBc>; Mon, 18 Nov 2002 13:01:32 -0500
Message-ID: <288F9BF66CD9D5118DF400508B68C44604758D70@orsmsx113.jf.intel.com>
From: "Feldman, Scott" <scott.feldman@intel.com>
To: "'immortal1015'" <immortal1015@hotpop.com>
Cc: linux-kernel@vger.kernel.org
Subject: RE: Does Intel E1000-82544 Gigabit Ethernet Card support Scatter/
	Gather mode
Date: Mon, 18 Nov 2002 10:07:54 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Does Intel E1000-82544 Gigabit Ethrenet card support 
> Scatter/Gather mode?

Yes, for the Tx zerocopy path.

-scott
