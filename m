Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267944AbUHEUIv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267944AbUHEUIv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 16:08:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267933AbUHEUIv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 16:08:51 -0400
Received: from fecls-03.atlarge.net ([129.41.63.139]:16201 "HELO
	fecls-03.atlarge.net") by vger.kernel.org with SMTP id S267941AbUHEUGj
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 16:06:39 -0400
Message-ID: <4112917A.3080003@cse.wustl.edu>
Date: Thu, 05 Aug 2004 14:58:50 -0500
From: "Mr. Berkley Shands" <berkley@cse.wustl.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040616
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: William Lee Irwin III <wli@holomorphy.com>
Subject: Re: Severe I/O performance regression 2.6.6 to 2.6.7 or 2.6.8-rc3
References: <41126811.7020607@dssimail.com> <20040805172531.GC17188@holomorphy.com>
In-Reply-To: <20040805172531.GC17188@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 05 Aug 2004 20:00:21.0468 (UTC) FILETIME=[D6B9A1C0:01C47B26]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:

>By any chance could you do binary search on the bk snapshots between
>2.6.6 and 2.6.7?
>
>
>-- wli
>
>  
>
the problem does not exist using 2.6.6-bk6, but exists on 2.6.6-bk7. 
-bk8 and -bk9 faile to build.
these are from patches-2.6.6-bk6 off snapshots/old and applied to a 
vanilla 2.6.6 kernel.

berkley

