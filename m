Return-Path: <linux-kernel-owner+w=401wt.eu-S1161001AbXAEIRb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161001AbXAEIRb (ORCPT <rfc822;w@1wt.eu>);
	Fri, 5 Jan 2007 03:17:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030365AbXAEIRb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Jan 2007 03:17:31 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:49373 "EHLO
	mtagate3.de.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030364AbXAEIRa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Jan 2007 03:17:30 -0500
In-Reply-To: <ada8xgi5w0n.fsf@cisco.com>
Subject: Re: do we have mmap abuse in ehca ?, was Re:  mmap abuse in ehca
To: Roland Dreier <rdreier@cisco.com>
Cc: Christoph Hellwig <hch@infradead.org>,
       Hoang-Nam Nguyen <hnguyen@de.ibm.com>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
X-Mailer: Lotus Notes Release 7.0 HF277 June 21, 2006
Message-ID: <OFBD9A4186.C6AB9FD1-ONC125725A.002D32C5-C125725A.002D8B42@de.ibm.com>
From: Christoph Raisch <RAISCH@de.ibm.com>
Date: Fri, 5 Jan 2007 09:17:27 +0100
X-MIMETrack: Serialize by Router on D12ML067/12/M/IBM(Release 6.5.5HF882 | September 26, 2006) at
 05/01/2007 09:17:27
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Roland Dreier <rdreier@cisco.com> wrote on 04.01.2007 22:20:40:

> Sorry I missed this original thread (on vacation since mid-December,
> just back today).  Anyway...
>
> ehca guys -- where do we stand on fixing this up?

We're looking into it.
It's a non-trivial change, because both kernel and userspace
driver have to be in sync again and need a good amount of test.

And beginning next week the christmas holiday season will be over.

Christoph Raisch

