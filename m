Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261785AbVFGA7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261785AbVFGA7T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Jun 2005 20:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261788AbVFGA7S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Jun 2005 20:59:18 -0400
Received: from nulgw1.unisys.co.jp ([202.233.47.71]:32395 "EHLO
	nulgw1.unisys.co.jp") by vger.kernel.org with ESMTP id S261785AbVFGA7J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Jun 2005 20:59:09 -0400
From: Hideki.Takahashi@uniadex.co.jp
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-2022-jp"
Content-Transfer-Encoding: 7bit
X-MimeOLE: Produced By Microsoft Exchange V6.0.6375.0
Subject: Dump analysis tool Alicia is released
Date: Tue, 7 Jun 2005 09:59:48 +0900
Message-ID: <034D06CB98C3DA48A82AC64141B6604E0596ACEF@AA02S1MB01.nthq01.unisys.co.jp>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Dump analysis tool Alicia is released
Thread-Index: AcVq/DLCU+sv4AKjTJanixtzlh/kKg==
To: <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 07 Jun 2005 00:59:48.0735 (UTC) FILETIME=[340AC0F0:01C56AFC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear all,

We are pleased to announce releasing a new dump analysis tool,
Alicia (Advanced LInux Crash-dump Interactive Analyzer).

---
The development of this program is partly supported by IPA
(Information-Technology Promotion Agency, Japan).

---

Alicia is a program that provides effective dump analysis environment
with power of Perl language. Alicia provides common access method to
kernel by wrapping the existing tool crash/lcrash and provides 
"scripting" function for saving and reusing the dump analysis procedures.
User can use existing crash/lcrash commands in addition to Alicia
commands. The command result can be saved as a variable and it can
be used as a parameter of another command. 
Please use this tool and give us some comments.

The following software is necessary for the compilation and the
execution of Alicia.
 - crash 3.8.5 or higher
 - Perl 5.8.0 or higher
 - Perl module Term::ReadKey 2.21 or higher
 - Perl module Term::ReadLine::Perl 1.0203 or higer

---
Alicia source code and documents are available in the following site,
http://sourceforge.net/projects/alicia/
http://alicia.sourceforge.net/

We prepared a mailing list written below in order to let users know
update of Alicia.
alicia-users@lists.sourceforge.net

And if you have any comments, please send to the above list, or to
another mailing-list written below.
alicia-devel@lists.sourceforge.net

Best regards,
All of the Alicia developers

-----------------
Hideki Takahashi
Uniadex,Ltd., Software Product Support
E-mail: Hideki.Takahashi@uniadex.co.jp

-
