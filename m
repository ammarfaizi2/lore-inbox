Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261558AbVETTsE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261558AbVETTsE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 15:48:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261561AbVETTsD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 15:48:03 -0400
Received: from smtpauth.newman.easystreet.com ([206.102.12.11]:19065 "EHLO
	smtpauth.easystreet.com") by vger.kernel.org with ESMTP
	id S261558AbVETTsA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 15:48:00 -0400
From: "ted creedon" <tcreedon@easystreet.com>
Cc: <openafs-info@openafs.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [OpenAFS] Re: Openafs 1.3.78 and kernel 2.4.29 oopses , same for 2.4.30 and openafs 1.3.82
Date: Fri, 20 May 2005 12:47:55 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcVdbTrYpyQqf8I4SpOeDcuF5fhDBAABmTMg
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
In-Reply-To: <Pine.LNX.4.62.0505202152200.3235@tassadar.physics.auth.gr>
Message-Id: <20050520194755.CC522B020@smtpauth.easystreet.com>
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/cpuinfo shows that the cmov instruction is there for Durons, PIII's
and P4's.

Its not for the Via C3 processors which you don't have.

tedc

