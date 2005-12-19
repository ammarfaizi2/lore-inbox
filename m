Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030274AbVLSIGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030274AbVLSIGS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 03:06:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbVLSIGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 03:06:18 -0500
Received: from mail.kontron-modular.com ([62.159.155.200]:37903 "EHLO
	kom-exchfe.kontron-modular.com") by vger.kernel.org with ESMTP
	id S1030274AbVLSIGS convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 03:06:18 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: Submitting patches for Kontron-boards with Freescale processors
Date: Mon, 19 Dec 2005 09:07:14 +0100
Message-ID: <DADA32856852FC458E0F96B664A6F55E011E2311@kom-mailsrv1.kontron-modular.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Submitting patches for Kontron-boards with Freescale processors
Thread-Index: AcYEc2NLDfHWbzpfR/GQ4kA3WyC7NQ==
From: "Claus Gindhart" <Claus.Gindhart@kontron.com>
To: <kumar.gala@freescale.com>
Cc: <linux-kernel@vger.kernel.org>,
       "Claus Gindhart" <Claus.Gindhart@kontron.com>
X-OriginalArrivalTime: 19 Dec 2005 08:06:16.0046 (UTC) FILETIME=[15D1D0E0:01C60473]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar,

in our department we have Linux 2.6 kernel ports for Kontron embedded computer boards with freescale processors 8245, 405, 8540, 8541, 8347, 8270, ...

We would like to start now to submit all these board supports to the vanilla kernel.

For the start we would select one of our common boards, e.g. the one with 8540/8541 processor.

My question is now:
Should we try to provide a patch with all HW-features of the board supported, or would it be better to start with a minimalistic patch, and then add support for additional devices onboard (e.g. IDE, RTC, SuperIO, ...) time by time ?

Or would it be better to provide the full feature set of this board at one time ?


Mit freundlichen Gruessen / Best regards

Claus Gindhart
SW R&D 
Kontron Modular Computers
phone :++49 (0)8341-803-374
mailto:claus.gindhart@kontron.com 
http://www.kontron.com 

