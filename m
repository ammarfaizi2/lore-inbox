Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261780AbUKJAHR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbUKJAHR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Nov 2004 19:07:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261796AbUKJAHQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Nov 2004 19:07:16 -0500
Received: from prgy-npn1.prodigy.com ([207.115.54.37]:46465 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S261780AbUKJAHI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Nov 2004 19:07:08 -0500
Message-ID: <41915C71.9090609@tmr.com>
Date: Tue, 09 Nov 2004 19:10:25 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Sanders <sandersn@btinternet.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem burning Audio CDs
References: <200411061049.38278.sandersn@btinternet.com>
In-Reply-To: <200411061049.38278.sandersn@btinternet.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Sanders wrote:
> Hi,
> 
> I've got problem with burning audio cds using k3b with 2.6.9 onwards. It gets 
> about 22% through and then cdrecord hangs saying '/usr/bin/cdrecord: Caught 
> interrupt.'
> 
> 2.6.7 works fine and I couldn't test 2.6.8.
> 
> I noticed that the CPU usage is alot higher in the caes where it fails
> 
> Buring data CDs and DVDs works fine.
> 
> I have also just noticed audio cd ripping doesn't work.
> 
> Has anyone else had this problem?

Are you going direct or using ide-scsi?

-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
