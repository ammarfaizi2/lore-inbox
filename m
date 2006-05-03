Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbWECMAa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbWECMAa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 May 2006 08:00:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965161AbWECMAa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 May 2006 08:00:30 -0400
Received: from smtpauth00.csee.siteprotect.com ([64.41.126.131]:42380 "EHLO
	smtpauth00.csee.siteprotect.com") by vger.kernel.org with ESMTP
	id S965160AbWECMAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 May 2006 08:00:30 -0400
From: "Yogesh Pahilwan" <pahilwan.yogesh@spsoftindia.com>
To: <linux-kernel@vger.kernel.org>
Subject: Problem while applying patch to 2.6.9 kernel
Date: Wed, 3 May 2006 17:32:02 +0530
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAvCUMqSY6jkeq1rIyy7sZ1cKAAAAQAAAAwZsyZCSXbUSO0mznjdzGqgEAAAAA@spsoftindia.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
Thread-Index: AcZuqWNQK9/RwEe/QNSj4YBys1SfiQ==
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1106
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kernel Folks,

I am facing some problem while applying patch to the 2.6.9 kernel.

I have done following to apply the patch:

# patch -p1 < ../../Patches/patch-ext3

But getting following things:

missing header for unified diff at line 3 of patch
(Stripping trailing CRs from patch.)
can't find file to patch at input line 3
Perhaps you used the wrong -p or --strip option?
The text leading up to this was:
--------------------------
|#--- ../A_CLEAN_FILE_SYSTEM/jbd/commit.c       2006-02-25
11:43:19.000000000 -0600
|#+++ commit.c  2006-03-29 20:53:29.000000000 -0600
--------------------------
File to patch:

Can anyone suggest what I am doing wrong while applying this patch or if the
command is correct then why patch is giving the above errors.

Any help can be greatly appreciated.

Thanks,
Yogesh

