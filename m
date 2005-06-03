Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261169AbVFCIBq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261169AbVFCIBq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 04:01:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261171AbVFCIBq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 04:01:46 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:19352 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S261169AbVFCIBp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 04:01:45 -0400
In-Reply-To: <20050602153834.5e4dc0eb.akpm@osdl.org>
Subject: Re: [patch 1/11] s390: cio max channels checks.
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
X-Mailer: Lotus Notes Build V651_12042003 December 04, 2003
Message-ID: <OF7EB72EA5.CB2E426D-ONC1257015.002B809A-C1257015.002C0AEF@de.ibm.com>
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Fri, 3 Jun 2005 10:01:03 +0200
X-MIMETrack: Serialize by Router on D12ML062/12/M/IBM(Release 6.53HF247 | January 6, 2005) at
 03/06/2005 10:01:02
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > [patch 1/11] s390: cio max channels checks.
>
> Which of these patches are considered to be 2.6.12 material?

All the patches are pretty short but if I had to choose I'd say
at least the following 4 patches should go into 2.6.12:

[patch 3/11] s390: ptrace peek and poke.
[patch 4/11] s390: uml ptrace fixes.
[patch 6/11] s390: in_interrupt vs. in_atomic.
[patch 9/11] s390: deadlock in appldata.

blue skies,
   Martin

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

