Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267993AbTBNXbP>; Fri, 14 Feb 2003 18:31:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268035AbTBNXbP>; Fri, 14 Feb 2003 18:31:15 -0500
Received: from air-2.osdl.org ([65.172.181.6]:18304 "EHLO doc.pdx.osdl.net")
	by vger.kernel.org with ESMTP id <S267993AbTBNXbO>;
	Fri, 14 Feb 2003 18:31:14 -0500
Date: Fri, 14 Feb 2003 15:41:00 -0800
From: Bob Miller <rem@osdl.org>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2.5.60 0/9] Update parallel port drivers to module loader API.
Message-ID: <20030214234100.GA13336@doc.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Updated the parallel port clase and all instance drivers to use the new module
API's.  This removes all the __check_region, __MOD_INC_USE_COUNT and
__MOD_DEC_USE_COUNT compiler warnings.


-- 
Bob Miller					Email: rem@osdl.org
Open Source Development Lab			Phone: 503.626.2455 Ext. 17
