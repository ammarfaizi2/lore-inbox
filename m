Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268670AbUIXKgl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268670AbUIXKgl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Sep 2004 06:36:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268672AbUIXKgl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Sep 2004 06:36:41 -0400
Received: from smtp200.mail.sc5.yahoo.com ([216.136.130.125]:33135 "HELO
	smtp200.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S268670AbUIXKga (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Sep 2004 06:36:30 -0400
Message-ID: <4153F8A1.8000008@yahoo.com.au>
Date: Fri, 24 Sep 2004 20:36:17 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040820 Debian/1.7.2-4
X-Accept-Language: en
MIME-Version: 1.0
To: William Lee Irwin III <wli@holomorphy.com>
CC: Michal Rokos <michal@rokos.info>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc2-mm3
References: <20040924014643.484470b1.akpm@osdl.org> <4153EED2.1050508@yahoo.com.au> <20040924102506.GB9106@holomorphy.com>
In-Reply-To: <20040924102506.GB9106@holomorphy.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
> Andrew Morton wrote:
> 
>>>+natsemi-remove-compilation-warnings.patch
>>>natsemi.c warning fixes
> 
> 
> On Fri, Sep 24, 2004 at 07:54:26PM +1000, Nick Piggin wrote:
> 
>>My card fails to work unless this change is backed out.
> 
> 
> Did you manage to boot successfully with the natsemi patch backed out?
> If so, could I get a bootlog to compare against?
> 

Yep. Hang on I'll send you it privately.
