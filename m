Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266467AbUGKBVt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266467AbUGKBVt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Jul 2004 21:21:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266473AbUGKBVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Jul 2004 21:21:49 -0400
Received: from ny-lasalle1b-127.buf.adelphia.net ([24.49.116.127]:3287 "EHLO
	sundance.gp") by vger.kernel.org with ESMTP id S266467AbUGKBVs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Jul 2004 21:21:48 -0400
Message-ID: <40F09625.5040303@eng.buffalo.edu>
Date: Sat, 10 Jul 2004 21:21:41 -0400
From: Gopikrishnan Sidhardhan <gs33@eng.buffalo.edu>
User-Agent: Mozilla Thunderbird 0.7 (X11/20040615)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: XFS: how to NOT null files on fsck?
References: <200407050247.53743.norberto+linux-kernel@bensa.ath.cx> <200407102143.49838.jk-lkml@sci.fi> <20040710184601.GB5014@taniwha.stupidest.org> <200407101555.27278.norberto+linux-kernel@bensa.ath.cx>
In-Reply-To: <200407101555.27278.norberto+linux-kernel@bensa.ath.cx>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norberto Bensa wrote:
> Chris Wedgwood wrote:
> 
>>XFS does not journal data.
> 
> 
> I think we all know that. The point, why the hell does it null files?

See http://www-106.ibm.com/developerworks/linux/library/l-fs9.html
- under the section 'Journaling'.

Thanks,
--GS

