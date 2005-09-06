Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964811AbVIFL0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964811AbVIFL0a (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 07:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbVIFL0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 07:26:30 -0400
Received: from dizz-a.telos.de ([212.63.141.211]:1414 "EHLO mail.telos.de")
	by vger.kernel.org with ESMTP id S964811AbVIFL0a convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 07:26:30 -0400
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: kbuild & C++
X-MimeOLE: Produced By Microsoft Exchange V6.0.4417.0
Date: Tue, 6 Sep 2005 13:23:56 +0200
Message-ID: <809C13DD6142E74ABE20C65B11A2439809C4BD@www.telos.de>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: kbuild & C++
Thread-Index: AcWy1XhQkAMBbMwPRh+EU5bNHUTEhA==
From: "Budde, Marco" <budde@telos.de>
To: <linux-kernel@vger.kernel.org>
X-telosmf: done
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

for one of our customers I have to port a Windows driver to
Linux. Large parts of the driver's backend code consists of
C++. 

How can I compile this code with kbuild? The C++ support
(I have tested with 2.6.11) of kbuild seems to be incomplete /
not working.

cu, Marco

Please send me a CC as e-mail.

