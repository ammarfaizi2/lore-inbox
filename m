Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTK1Vj0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Nov 2003 16:39:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263522AbTK1Vj0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Nov 2003 16:39:26 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:52149 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263500AbTK1VjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Nov 2003 16:39:22 -0500
Message-ID: <3FC7C05F.8070606@nortelnetworks.com>
Date: Fri, 28 Nov 2003 16:38:39 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
Cc: linux-kernel@vger.kernel.org, root@chaos.analogic.com,
       szepe@pinerecords.com, torvalds@osdl.org
Subject: Re: BUG (non-kernel), can hurt developers.
References: <UTC200311282121.hASLLOm22001.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
>>You may also want to mention the SUS async-safe list as well,
>>since there are some additional functions there.
>>
> 
> Are you sure?
> Which? In which SUS version?

My bad.  SUS references the posix list.  I must have been looking at an 
old function list.  POSIX should be sufficient.

Chris



-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

