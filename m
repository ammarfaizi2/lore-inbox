Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266728AbSKKRqr>; Mon, 11 Nov 2002 12:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266730AbSKKRqr>; Mon, 11 Nov 2002 12:46:47 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:25217 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id <S266728AbSKKRqr>; Mon, 11 Nov 2002 12:46:47 -0500
Message-ID: <3DCFEE97.9010301@nortelnetworks.com>
Date: Mon, 11 Nov 2002 12:53:27 -0500
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: strange behaviour with statfs() call, looking for advice -- followup
References: <3DCFDE0A.1030506@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:7Q26:EXCH] wrote:

> The system in question is a yellowdog system, but the same problem is 
> present on a recent mandrake box as well.  Is this a redhat issue?

It appears that this is a glibc problem, and it is still present in the 
latest glibc.  Just a warning to people using statfs().

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

