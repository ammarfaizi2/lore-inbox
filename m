Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262940AbTLDB2O (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Dec 2003 20:28:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263024AbTLDB2O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Dec 2003 20:28:14 -0500
Received: from smtp11.eresmas.com ([62.81.235.111]:40394 "EHLO
	smtp11.eresmas.com") by vger.kernel.org with ESMTP id S262940AbTLDB2J
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Dec 2003 20:28:09 -0500
Message-ID: <3FCE8D7C.4070704@wanadoo.es>
Date: Thu, 04 Dec 2003 02:27:24 +0100
From: Xose Vazquez Perez <xose@wanadoo.es>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: gl, es, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: XFS for 2.4
X-Enigmail-Version: 0.63.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

davidsen wrote:

> Larry McVoy wrote:

>> It is also not unreasonable to reject a set of changes right before
>> freezing 2.4.  2.4 is supposed to be dead.  Add XFS and what's next?
>> Who's pet feature needs to go in?

> Now that is bullshit and you know it! This is not a pet feature, this
> is code which has has been stable for years. There just aren't any
> other candidates, all the other FS stuff went in with less testing and
> have fewer users now (JFS as example). This is also not code offered
> "right before a freeze" this code has been offered version by version
> for two bleepin' years, has it not? There's no slippery slope, there
> are no other major features which have proven long-term stability. Fell
> free to name them if I'm wrong...

Really XFS code is not the big problem. But the changes in other parts [1]
are really problematic when 2.4 is a *must be stable* .
Is so hard to understand ?

If Marcelo believes that XFS changes, or any other feature or code,
must not be in 2.4.24, is god's word and End Of Thread.

Christoph Hellwig is reviewing the XFS code, and we will see ...


[1] http://marc.theaimsgroup.com/?l=linux-xfs&m=107025984901582&w=2

