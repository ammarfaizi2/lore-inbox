Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263670AbUC3OIH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Mar 2004 09:08:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263668AbUC3OIG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Mar 2004 09:08:06 -0500
Received: from postoffice9.mail.cornell.edu ([132.236.56.39]:1779 "EHLO
	postoffice9.mail.cornell.edu") by vger.kernel.org with ESMTP
	id S263670AbUC3OHd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Mar 2004 09:07:33 -0500
Message-ID: <40697F1F.5050003@cornell.edu>
Date: Tue, 30 Mar 2004 09:07:27 -0500
From: Ivan Gyurdiev <ivg2@cornell.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20040214 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
CC: Marc-Christian Petersen <m.c.p@wolk-project.de>,
       Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Dominik Karall <dominik.karall@gmx.net>
Subject: Re: Linux 2.6.5-rc3
References: <Pine.LNX.4.58.0403292129200.1096@ppc970.osdl.org>	 <40690B84.7060203@cornell.edu> <200403300814.21205.dominik.karall@gmx.net>	 <200403301026.09039@WOLK> <1080650274.1134.0.camel@teapot.felipe-alfaro.com>
In-Reply-To: <1080650274.1134.0.camel@teapot.felipe-alfaro.com>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe Alfaro Solana wrote:
> On Tue, 2004-03-30 at 10:26, Marc-Christian Petersen wrote:
> 
>>On Tuesday 30 March 2004 08:14, Dominik Karall wrote:
>>
>>Hi Dominik,
>>
>>
>>>Take a look in your config file, if 4KSTACK is enabled, it shouldn't.
>>
>>err, we are talking about 2.6.5-rc3, not 2.6.5-rc*-mm* :p
> 
> 
> What about CONFIG_REGPARM? Did you enable it?

No, it's off...
I'll do some more testing and figure out which changeset breaks it.


