Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030307AbWGSUzG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030307AbWGSUzG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 16:55:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030309AbWGSUzG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 16:55:06 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.83]:64745 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP
	id S1030307AbWGSUzD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 16:55:03 -0400
Message-ID: <44BE9C22.9060209@cmu.edu>
Date: Wed, 19 Jul 2006 16:54:58 -0400
From: George Nychis <gnychis@cmu.edu>
User-Agent: Thunderbird 1.5.0.4 (X11/20060612)
MIME-Version: 1.0
To: Brandon Philips <brandon@ifup.org>
CC: lkml <linux-kernel@vger.kernel.org>
Subject: Re: suspend/hibernate to work on thinkpad x60s?
References: <30DF6C25102A6E4BBD30B26C4EA1DCCC0162E099@MEMEXCH10V.corp.ds.fedex.com> <200607191742.32609.rjw@sisk.pl> <44BE5589.4070403@cmu.edu> <200607192102.17438.rjw@sisk.pl> <44BE8D7C.8070107@cmu.edu> <20060719202333.GA8705@plankton.ifup.org>
In-Reply-To: <20060719202333.GA8705@plankton.ifup.org>
X-Enigmail-Version: 0.94.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Is there only 1 patch file?  I only see the 1 patch file on the link you
sent me, i applied it cleanly to a 2.6.18-rc1-git7 kernel and i still
have the same problem

- George


Brandon Philips wrote:
> On 15:52 Wed 19 Jul 2006, George Nychis wrote:
>> I see, so I guess I still have a disk problem after any type of suspend,
>> has anyone gotten it to fully work with AHCI? any more suggestions?
>>
>> I greatly appreciate all the help.
> 
> Hey George-
> 
> As was said earlier Forrest Zhao has created patches against 2.6.18-rc1
> and posted[1] them to the linux-ide mailing list.  These patches restore
> AHCI drives properly after a suspend.
> 
> 	Brandon
> 
> [1] http://marc.theaimsgroup.com/?l=linux-ide&m=115277002327654&w=2
> 
> 
