Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265964AbUGTOhM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265964AbUGTOhM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 10:37:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265962AbUGTOhL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 10:37:11 -0400
Received: from gandalf.impreva.com ([212.29.208.227]:17866 "EHLO
	gandalf.webcohort.com") by vger.kernel.org with ESMTP
	id S265958AbUGTOe5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 10:34:57 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: module name is KBUILD_MODNAME
Date: Tue, 20 Jul 2004 17:36:01 +0200
Message-ID: <96242ACDF1723A4BBF70D21211FB9B2306368E@shrek.webcohort.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: module name is KBUILD_MODNAME
Thread-Index: AcRubxDYert/zd/1QnisMkm9yfr5jQ==
From: "Idan Spektor" <idan@imperva.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,
I am migrating my loadable module to work with the 2.6 kernel.
I have actually managed to make everything working except for
one thing. When I am loading my module (using the new
modprobe), its name, as appearing in lsmod, is KBUILD_MODNAME instead
of the module's real name. What am I missing? Is there
a define for the module's name that I should add somewhere?

 Kind Regards
  Idan

