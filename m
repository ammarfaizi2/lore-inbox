Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSIJStA>; Tue, 10 Sep 2002 14:49:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSIJStA>; Tue, 10 Sep 2002 14:49:00 -0400
Received: from gherkin.frus.com ([192.158.254.49]:62600 "HELO gherkin.frus.com")
	by vger.kernel.org with SMTP id <S318009AbSIJSs7>;
	Tue, 10 Sep 2002 14:48:59 -0400
Message-Id: <m17oq8v-0005khC@gherkin.frus.com>
From: rct@gherkin.frus.com (Bob_Tracy)
Subject: 2.5.X config: USB speedtouch driver
To: linux-kernel@vger.kernel.org
Date: Tue, 10 Sep 2002 13:53:45 -0500 (CDT)
X-Mailer: ELM [version 2.4ME+ PL82 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Minor nit: the subject driver depends on ATM, so a config-time check to
see if ATM support is enabled is appropriate.

-- 
-----------------------------------------------------------------------
Bob Tracy                   WTO + WIPO = DMCA? http://www.anti-dmca.org
rct@frus.com
-----------------------------------------------------------------------
