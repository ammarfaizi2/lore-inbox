Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268911AbUHUIuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268911AbUHUIuG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 04:50:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268912AbUHUIuF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 04:50:05 -0400
Received: from qfep04.superonline.com ([212.252.122.160]:24247 "EHLO
	qfep04.superonline.com") by vger.kernel.org with ESMTP
	id S268911AbUHUIuB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 04:50:01 -0400
From: "Josan Kadett" <corporate@superonline.com>
To: "'Lee Revell'" <rlrevell@joe-job.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: RE: Entirely ignoring TCP and UDP checksum in kernel level
Date: Sat, 21 Aug 2004 11:50:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <1093077667.854.69.camel@krustophenia.net>
Thread-Index: AcSHWpwp8CY2M0CtTYmscTRu94UseAACK/1w
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1409
Message-Id: <S268911AbUHUIuB/20040821085001Z+1971@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the very original linux-kernel mailing list, and if I cannot find an
answer here, then nowhere on earth can this answer be found. I also saw some
other messages regarding the same issue on the net. None of them is answered
correctly; and also as if this is a very "forbidden" thing to disable the
checksums, most replies are as if they are "unbreakable rules of god".
Really, I am losing my patience with this. It is also very odd to write a
low-level application in order to just disable a "feature" of the kernel to
deal with a faulty piece of embedded firmware.

In reply to;
------------
He already stated that he was dealing with a very expensive, very broken
piece of hardware, and he needs a way to work around it.  Many of us
have been in this situation, I will not name names ;-).  Telling him to
just replace it is not helpful.

Lee




