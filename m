Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267376AbUITWTh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267376AbUITWTh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 18:19:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUITWTh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 18:19:37 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:51363 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S267376AbUITWTf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 18:19:35 -0400
Date: Mon, 20 Sep 2004 17:19:33 -0500
To: linuxppc64-dev@ozlabs.org
Cc: linux-kernel@vger.kernel.org, paulus@samba.org, anton@samba.org
Subject: [PATCH] [PPC64] [TRIVIAL] Janitor whitespace in pSeries_pci.c
Message-ID: <20040920221933.GB1872@austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040818i
From: Linas Vepstas <linas@austin.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,


This file mixes tabs with 8 spaces, leading to poor display 
if one's editor doesn't have tab-stops set to 8.   Please apply.

--linas

Signed-off-by: Linas Vepstas <linas@linas.org>
