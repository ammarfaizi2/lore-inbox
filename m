Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030363AbVIOMzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030363AbVIOMzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 08:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030390AbVIOMzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 08:55:44 -0400
Received: from dizz-a.telos.de ([212.63.141.211]:24712 "EHLO mail.telos.de")
	by vger.kernel.org with ESMTP id S1030363AbVIOMzo convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 08:55:44 -0400
Subject: How to find "Unresolved Symbols"
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Date: Thu, 15 Sep 2005 14:47:02 +0200
Content-class: urn:content-classes:message
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Message-ID: <809C13DD6142E74ABE20C65B11A2439809C4CA@www.telos.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: How to find "Unresolved Symbols"
Thread-Index: AcW585H6Ys+a3yG1T9O3giM1FNptxQ==
From: "Budde, Marco" <budde@telos.de>
To: <linux-kernel@vger.kernel.org>
X-telosmf: done
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am working on a larger kernel module.
This module will be based on a lot of
portable code, for which I have to implement
the OS depended code.

At the moment I can compile the complete
code into a module. Some of OS depended
code is still missing, but I do not get
any warnings from kbuild.

When I try to load the module, I can a really
strange error message:

 insmod: error inserting 'foo.o': -795847932 Function not implemented

What does that mean? How can I get a list
of missing symbols?

cu, Marco

-- 
telos EDV Systementwicklung GmbH

