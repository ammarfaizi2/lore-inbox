Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278358AbRJWX3T>; Tue, 23 Oct 2001 19:29:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278375AbRJWX3I>; Tue, 23 Oct 2001 19:29:08 -0400
Received: from lsmls02.we.mediaone.net ([24.130.1.15]:34045 "EHLO
	lsmls02.we.mediaone.net") by vger.kernel.org with ESMTP
	id <S278358AbRJWX3C>; Tue, 23 Oct 2001 19:29:02 -0400
Message-ID: <3BD5FD98.1AACC12D@kegel.com>
Date: Tue, 23 Oct 2001 16:30:32 -0700
From: Dan Kegel <dank@kegel.com>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.7-2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        riel@conectiva.com.br
Subject: Re: Issue with max_threads (and other resources) and highmem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik wrote:
> ... A sane upper limit for
> max_threads would be 10000, this also keeps in mind the
> fact that we only have 32000 possible PIDs, some of which
> could be taken by task groups, etc...

?  I thought the 2.4 kernel had switched to 32 bit pid's long ago.
Where does the limit of 32000 possible PIDs come from?
- Dan
