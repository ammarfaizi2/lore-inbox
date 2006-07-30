Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932390AbWG3SBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932390AbWG3SBj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWG3SBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:01:39 -0400
Received: from wasp.net.au ([203.190.192.17]:52699 "EHLO wasp.net.au")
	by vger.kernel.org with ESMTP id S932390AbWG3SBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:01:38 -0400
Message-ID: <44CCF3F9.2000300@wasp.net.au>
Date: Sun, 30 Jul 2006 22:01:29 +0400
From: Brad Campbell <brad@wasp.net.au>
User-Agent: Thunderbird 1.5.0.4 (X11/20060615)
MIME-Version: 1.0
To: Jesper Juhl <jesper.juhl@gmail.com>
CC: Guillaume Chazarain <guichaz@yahoo.fr>, Greg KH <greg@kroah.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.18-rc3 does not like an old udev (071)
References: <44CCEC96.3020607@yahoo.fr> <9a8748490607301043r5ffc1a87u782a24a2695058be@mail.gmail.com>
In-Reply-To: <9a8748490607301043r5ffc1a87u782a24a2695058be@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:
> On 30/07/06, Guillaume Chazarain <guichaz@yahoo.fr> wrote:
>> Hi,
>>
>> When updating only the kernel to 2.6.18-rc3 on Ubuntu Dapper/x86,
>> /dev/usblp0
>> is no more created on boot. If I manually create it, it works fine.
>>
>> Vanilla udev from Dapper: version 079 (Documentation/Changes requires
>> udev 071 ;-) ).
>>
> 
> Hmm, udev 071 works fine here...
> i must admit though that I don't have any USB printers, so what I have

I think you will find he's pointing out that he's running udev 079 and the kernel 
Documentation/Changes file states :-
o  udev                   071                     # udevinfo -V

brad@bklaptop2:~$ zcat /usr/share/doc/udev/changelog.gz | head -n1
Summary of changes from v078 to v079

Same distribution :)

Brad
-- 
"Human beings, who are almost unique in having the ability
to learn from the experience of others, are also remarkable
for their apparent disinclination to do so." -- Douglas Adams
