Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279753AbRJYLRq>; Thu, 25 Oct 2001 07:17:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279754AbRJYLRf>; Thu, 25 Oct 2001 07:17:35 -0400
Received: from smtp1.ndsu.NoDak.edu ([134.129.111.146]:39179 "EHLO
	smtp1.ndsu.nodak.edu") by vger.kernel.org with ESMTP
	id <S279753AbRJYLRX>; Thu, 25 Oct 2001 07:17:23 -0400
Message-ID: <3BD7F44C.7020007@ndsu.nodak.edu>
Date: Thu, 25 Oct 2001 06:15:24 -0500
From: Reid Hekman <reid.hekman@ndsu.nodak.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011018
X-Accept-Language: en-us
MIME-Version: 1.0
To: Marton Kadar <marton.kadar@freemail.hu>
CC: linux-kernel@vger.kernel.org
Subject: Re: concurrent VM subsystems
In-Reply-To: <freemail.20010925100655.37794@fm3.freemail.hu>
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marton Kadar wrote:

> Just an idea from an absolute layman who keeps
> an eye on Kernel Traffic:
> 
> Isn't it possible to include both VM approaches in the
> kernel sources? It would be nice to be able to choose
> at compile time through a configuration option.
> Perhaps Andrea Arcangeli's version could be marked 
> experimental.


We've been over this already, while it would be nice for testing if the

two VM's could be compared without all the extra variables of the Linus
and -ac trees it's not going to happen. It would be a big headache to 
maintain all the extra source that would involve and all the changes to 
other stuff you'd have to patch to make the two interchangeable. This 
has been discussed for almost a week now and I'm sure it will show up
in next weeks kernel-traffic. I'd encourage layperson's to wait till
then to see how this story continues. <announcer_voice> So until next
week dear viewers! Same bat-time, same bat-channel!</announcer_voice>


If you're interested in seeing some of the discussion, here's a
reasonable jump off point in the archives...

http://www.uwsg.indiana.edu/hypermail/linux/kernel/0110.2/1149.html



Just trying to better the signal-to-noise on linux-kernel...
Regards,
Reid

