Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267472AbTBUOnZ>; Fri, 21 Feb 2003 09:43:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267476AbTBUOnZ>; Fri, 21 Feb 2003 09:43:25 -0500
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:47614 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S267474AbTBUOnX>; Fri, 21 Feb 2003 09:43:23 -0500
Message-ID: <3E563D53.8020102@nortelnetworks.com>
Date: Fri, 21 Feb 2003 09:53:07 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: jamesbuch@iprimus.com.au
Cc: Rik van Riel <riel@imladris.surriel.com>,
       Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org
Subject: Re: Linux kernel rant
References: <200302211551.28222.jamesbuch@iprimus.com.au> <200302211717.23993.jamesbuch@iprimus.com.au> <Pine.LNX.4.50L.0302201519210.2329-100000@imladris.surriel.com> <200302211725.58197.jamesbuch@iprimus.com.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Buchanan wrote:
> On Fri, 21 Feb 2003 05:19 am, Rik van Riel wrote:
> 
>>No IDE disks or modern SCSI controllers in your machine ?
>>
> 
> The ones I use are not forbidden to be seen by me, written under an 
> NDA or otherwise.  No, no modern SCSI controllers.

I think what you're missing is that many drivers are *written* under an 
NDA but then the resulting code is released under an open license.

You're free to use the resulting driver, but the writer can't talk about 
exactly how it works.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

