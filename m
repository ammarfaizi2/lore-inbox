Return-Path: <linux-kernel-owner+w=401wt.eu-S1425567AbWLHPgd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1425567AbWLHPgd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 8 Dec 2006 10:36:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1425575AbWLHPgd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Dec 2006 10:36:33 -0500
Received: from mtagate4.uk.ibm.com ([195.212.29.137]:58816 "EHLO
	mtagate4.uk.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1425571AbWLHPgc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Dec 2006 10:36:32 -0500
Subject: Re: [PATCH] WorkStruct: Fix S390 driver workstruct usage
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
To: David Howells <dhowells@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux390@de.ibm.com,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
In-Reply-To: <20061208145940.21411.77769.stgit@warthog.cambridge.redhat.com>
References: <20061208145940.21411.77769.stgit@warthog.cambridge.redhat.com>
Content-Type: text/plain
Organization: IBM Corporation
Date: Fri, 08 Dec 2006 16:36:24 +0100
Message-Id: <1165592184.17999.3.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-12-08 at 14:59 +0000, David Howells wrote:
> Fix S390 driver workstruct reduction problems.

Bad timing. I just created similar patch and pushed it to git390. The
only part it does not cover is the ctrlchar.c part. I hope you didn't
spent too much time on this.

-- 
blue skies,
  Martin.

Martin Schwidefsky
Linux for zSeries Development & Services
IBM Deutschland Entwicklung GmbH

"Reality continues to ruin my life." - Calvin.


