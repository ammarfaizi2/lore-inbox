Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262499AbTHUHls (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 03:41:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262502AbTHUHls
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 03:41:48 -0400
Received: from zcars0m9.nortelnetworks.com ([47.129.242.157]:35326 "EHLO
	zcars0m9.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S262499AbTHUHlq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 03:41:46 -0400
Message-ID: <3F4437D7.9090706@nortelnetworks.com>
Date: Wed, 20 Aug 2003 23:09:11 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Jeff Garzik <jgarzik@pobox.com>, Linus Torvalds <torvalds@osdl.org>,
       akpm@ravnborg.org, Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: kbuild: Separate ouput directory support
References: <20030819214144.GA30978@mars.ravnborg.org> <3F429C5D.4010201@pobox.com> <20030819215656.GE1791@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Tue, Aug 19, 2003 at 05:53:33PM -0400, Jeff Garzik wrote:
> 
>>Is it possible, with your patches, to build from a kernel tree on a 
>>read-only medium?
>>
> 
> Yes, thats possible. But I have seen that as a secondary possibility.
> But I know people has asked about the possibility to build a kernel
> from src located on a CD. And thats possible with this patch.

This rocks.  I've been cleaning and rebuilding with different configs up 
till now.  Once we switch to 2.6 this will make things much nicer.

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

