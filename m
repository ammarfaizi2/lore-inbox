Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262253AbTJFPIt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 11:08:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262260AbTJFPIt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 11:08:49 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:57011 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262253AbTJFPIq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 11:08:46 -0400
Message-ID: <3F818574.3000403@nortelnetworks.com>
Date: Mon, 06 Oct 2003 11:08:36 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: bert hubert <ahu@ds9a.nl>
Cc: "Frederick, Fabian" <Fabian.Frederick@prov-liege.be>,
       "Linux-Kernel (E-mail)" <linux-kernel@vger.kernel.org>
Subject: Re: Futex
References: <D9B4591FDBACD411B01E00508BB33C1B01EC852D@mesadm.epl.prov-liege.be> <20031006075039.GA12376@outpost.ds9a.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bert hubert wrote:
> On Mon, Oct 06, 2003 at 09:22:19AM +0200, Frederick, Fabian wrote:
> 
>>Hi,
>>
>>	Why don't we have any futex doc included ?
>>Nothing about futexfs nor userspace futex usage ....
>>
> 
> http://ds9a.nl/futex-manpages/

Just a note: the library mentioned needs a patch to compile on the 
latest kernel (mostly just to handle the additional parm in the futex 
syscall).  I've sent it to Rusty for the next version.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

