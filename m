Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265009AbUDUGY4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265009AbUDUGY4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 02:24:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264972AbUDUGYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 02:24:23 -0400
Received: from miranda.se.axis.com ([193.13.178.2]:13470 "EHLO
	miranda.se.axis.com") by vger.kernel.org with ESMTP id S265044AbUDUGWc convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 02:22:32 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [RFC] kbuild: Documentation - how to build external modules
Date: Wed, 21 Apr 2004 08:22:25 +0200
Message-ID: <50BF37ECE4954A4BA18C08D0C2CF88CB366386@exmail1.se.axis.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [RFC] kbuild: Documentation - how to build external modules
Thread-Index: AcQnKO0gjcdNMd57SFmr22qegkUIaAAPs8gA
From: "Peter Kjellerstedt" <peter.kjellerstedt@axis.com>
To: "Sam Ravnborg" <sam@ravnborg.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 21 Apr 2004 06:22:27.0328 (UTC) FILETIME=[0478A000:01C42769]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of Sam Ravnborg
> Sent: Tuesday, April 20, 2004 23:52
> To: linux-kernel@vger.kernel.org
> Subject: [RFC] kbuild: Documentation - how to build external modules
> 
> This is just first wrap-up of some text about building 
> external modules. There are a few unfinished chapters - 
> but's too late today.
> 
> Please let me know what you expect to see in here - which is 
> not covered eiter direct or via an empty heading.
> 
> 	Sam

What about external modules that need to be configured
using make config & co? Is that possible with this system?

//Peter
