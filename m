Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268520AbTBODT7>; Fri, 14 Feb 2003 22:19:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268521AbTBODT7>; Fri, 14 Feb 2003 22:19:59 -0500
Received: from gherkin.frus.com ([192.158.254.49]:2691 "EHLO gherkin.frus.com")
	by vger.kernel.org with ESMTP id <S268520AbTBODT7>;
	Fri, 14 Feb 2003 22:19:59 -0500
Subject: 2.5.61: ipv6 as module fails: xfrm6_get_type
To: linux-kernel@vger.kernel.org
Date: Fri, 14 Feb 2003 21:29:53 -0600 (CST)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Message-Id: <20030215032953.31A174EEF@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy(0000))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

xfrm6_get_type() is undefined when one tries to build 2.5.61 with
IPv6 configured as a module.  CONFIG_IPV6=y builds fine.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
