Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261586AbVFMOnu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261586AbVFMOnu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 10:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261587AbVFMOnu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 10:43:50 -0400
Received: from odin2.bull.net ([192.90.70.84]:45792 "EHLO odin2.bull.net")
	by vger.kernel.org with ESMTP id S261586AbVFMOnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 10:43:49 -0400
Subject: RT and kernel debugger ( 2.6.12rc6  + RT  > 48-00 )
From: "Serge Noiraud" <serge.noiraud@bull.net>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain
Organization: BTS
Message-Id: <1118673083.10717.83.camel@ibiza.btsn.frna.bull.fr>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-5.1.100mdk 
Date: Mon, 13 Jun 2005 16:31:24 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

	I would like to know what kernel debugger you propose over the RT
patch. I used to test kgdb, but since spinlock modification, it doesn't
work anymore.

Does someone work over RT to port a kernel debugger ?

