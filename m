Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261215AbTINQzc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 12:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbTINQzc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 12:55:32 -0400
Received: from mx1.redhat.com ([66.187.233.31]:38405 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261215AbTINQz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 12:55:29 -0400
Message-ID: <3F649D70.4050901@ckloiber.com>
Date: Sun, 14 Sep 2003 12:55:12 -0400
From: Chris Kloiber <ckloiber@ckloiber.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Willy Tarreau <willy@w.ods.org>
CC: Neil Brown <neilb@cse.unsw.edu.au>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.23-pre4 => NFSD problem on alpha
References: <Pine.LNX.4.44.0309121528290.3893-100000@logos.cnet> <20030914113421.GA705@alpha.home.local> <16228.21909.391485.229455@notabene.cse.unsw.edu.au> <20030914121540.GA549@alpha.home.local>
In-Reply-To: <20030914121540.GA549@alpha.home.local>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sun, Sep 14, 2003 at 09:48:37PM +1000, Neil Brown wrote:
>  
> 
>>I know what broke it.  Please try this patch and let me know.
> 
> 
> It fixed it, and it works OK now. Congratulations for being so fast, Neil !
> 
> Thanks,
> Willy

Can you tell me how to get any recent kernel to compile on Alpha?  I run 
Red Hat 7.2/Alpha on my UP2000 and can't get anything newer than a 
2.4.9-32.7 to compile/run on it. Even the 2.4.18-27.7.x.hp supplied by 
HP panics on boot. I filed some bugs on bugzilla.kernel.org against 
2.6.0-test4-bk8 and they just sit there in NEW state. #1196 and 1197 
IIRC if you are interested. Thanks.

-- 
Chris Kloiber


