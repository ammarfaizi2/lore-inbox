Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262031AbTEENx2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 09:53:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTEENx2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 09:53:28 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:24792 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262031AbTEENx1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 09:53:27 -0400
Message-ID: <3EB66F8C.8050402@nortelnetworks.com>
Date: Mon, 05 May 2003 10:05:00 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Felix von Leitner <felix-kernel@fefe.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.68] Scalability issues
References: <20030504173956.GA28370@codeblau.de> <20030504194451.GA29196@codeblau.de> <1052079133.27465.14.camel@rth.ninka.net> <20030505075118.GA352@codeblau.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:
> Thus spake David S. Miller (davem@redhat.com):

>>Either reproduce without the nvidia module loaded, or take
>>your report to nvidia.
>>
> 
> Thank you for this stunning display of unprofessionalism and zealotry.
> People like you keep free software alive.

He may not have put it as politely as you would like, but there really is no way 
to debug a problem in a kernel which has been tainted by binary-only drivers. 
That driver could have done literally anything to the kernel on loading.

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

