Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWHVN7y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWHVN7y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 09:59:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932260AbWHVN7y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 09:59:54 -0400
Received: from smtpout.mac.com ([17.250.248.173]:30966 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932259AbWHVN7x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 09:59:53 -0400
In-Reply-To: <17643.2921.654137.143271@stoffel.org>
References: <20060821184527.GA21938@kroah.com> <20060821194616.GC12928@redhat.com> <20060821214349.GA1885@suse.de> <17643.2921.654137.143271@stoffel.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <CEC585A0-09D8-44E9-ABEA-58B65D2A1CA7@mac.com>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 00/20] 2.6.17-stable review
Date: Tue, 22 Aug 2006 09:59:10 -0400
To: John Stoffel <john@stoffel.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Aug 22, 2006, at 09:49:29, John Stoffel wrote:
> "Greg" == Greg KH <gregkh@suse.de> writes:
>> On Mon, Aug 21, 2006 at 03:46:16PM -0400, Dave Jones wrote:
>>> Any chance of a 2.6.17.10-rc1 rollup patch again, like you did  
>>> for .8?
>
>> Oops, forgot to do that, thanks for reminding me.  It can be found  
>> at:
>> http://www.kernel.org/pub/linux/kernel/people/gregkh/stable/ 
>> patch-2.6.17.10-rc1.gz
>
>> And yes, it's not in the "main" v2.6 subdirectories, I'm not going  
>> to put it there anymore as it confuses too many scripts/people.
>
> So what if they're confused?  If they're official releases, blessed  
> with holy penguin pee, then shouldn't they be in the standard  
> release area?

Well, except for the fact that the pre-stable RC patches are neither  
"official" nor "releases".  They're just a combo rollup patch of all  
of the proposed stable patches before they've been batch reviewed on  
the LKML. (IOW: just for ease of testing)

Cheers,
Kyle Moffett


