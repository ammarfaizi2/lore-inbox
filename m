Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264419AbTLBV7M (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Dec 2003 16:59:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264420AbTLBV7M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Dec 2003 16:59:12 -0500
Received: from s383.jpl.nasa.gov ([137.79.94.127]:49116 "EHLO
	s383.jpl.nasa.gov") by vger.kernel.org with ESMTP id S264419AbTLBV7I
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Dec 2003 16:59:08 -0500
Message-ID: <3FCD0AA2.2030306@jpl.nasa.gov>
Date: Tue, 02 Dec 2003 13:56:50 -0800
From: Bryan Whitehead <driver@jpl.nasa.gov>
Organization: Jet Propulsion Laboratory
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en, zh, zh-cn, zh-hk, zh-sg, zh-tw, ja
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: "Peter C. Norton" <spacey-linux-kernel@lenin.nu>,
       Christoph Hellwig <hch@infradead.org>, Ian Kent <raven@themaw.net>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4 future
References: <Pine.LNX.4.44.0312011212090.13692-100000@logos.cnet> <Pine.LNX.4.44.0312012302310.9674-100000@raven.themaw.net> <20031201153316.B3879@infradead.org> <20031201213651.GK18176@lenin.nu> <1070322894.5260.5.camel@laptop.fenrus.com> <20031202201040.GX18176@lenin.nu> <20031202201800.GB2030@devserv.devel.redhat.com>
In-Reply-To: <20031202201800.GB2030@devserv.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> On Tue, Dec 02, 2003 at 12:10:40PM -0800, Peter C. Norton wrote:
> 
>>On Tue, Dec 02, 2003 at 12:54:54AM +0100, Arjan van de Ven wrote:
>>
>>>On Mon, 2003-12-01 at 22:36, Peter C. Norton wrote:
>>>`
>>>
>>>>encouraging the distros to get behind autofs4 (hint hint, redhat,
>>>>hint).
>>>
>>>I suspect you'll have a really hard time finding ANY distro that still
>>>wants to actively develop new products on a 2.4 codebase.
>>
>>Perhaps, but some rather large customers of AS2.1, would like it if
>>redhat could deliver the large outstanding automounting features for
>>their (mainly sun) environments.  Since these environments resist
>>change, upgrading a kernel to include a newer autofs4 is more likely
>>than upgrading the whole system.
> 
> 
> and putting a feature into 2.4.23 is going to help/change that... how ?

 From a sysadmin with rather large Solaris / Linux install base I'd love 
to see a fully working autofs in 2.4. But I would loath running 2.6 on a 
much needed production system... Hacking around the junk version of 
autofs in 2.4 is a pain.

-- 
Bryan Whitehead
SysAdmin - JPL - Interferometry and Large Optical Systems
Phone: 818 354 2903
driver@jpl.nasa.gov

