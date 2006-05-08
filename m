Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWEHSej@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWEHSej (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 14:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932480AbWEHSej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 14:34:39 -0400
Received: from mail.teneros.com ([65.113.45.16]:49196 "EHLO mail.teneros.com")
	by vger.kernel.org with ESMTP id S932437AbWEHSei convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 14:34:38 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 8BIT
Subject: [BUG] Build error in modpost.c for latest git
Date: Mon, 8 May 2006 11:34:35 -0700
Message-ID: <384422E6306C7D439E6C327F5FCFFDCE011C236F@EXCH-US02.nuitysystems.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [BUG] Build error in modpost.c for latest git
Thread-Index: AcZyzg4ukRXlgsQWS0upEm8rP6XiKg==
From: "Hua Zhong" <Hua.Zhong@teneros.com>
To: "Linus Torvalds" <torvalds@osdl.org>,
       "Linux Kernel" <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 08 May 2006 18:34:36.0154 (UTC) FILETIME=[0EAAC5A0:01C672CE]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/mod/modpost.c: In function `check_sec_ref':
scripts/mod/modpost.c:716: error: cast to union type from type not
present in union
make[2]: *** [scripts/mod/modpost.o] Error 1
make[1]: *** [scripts/mod] Error 2
make: *** [scripts] Error 2
