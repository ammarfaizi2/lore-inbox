Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261675AbUCBP0N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261682AbUCBP0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:26:13 -0500
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:48620 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261675AbUCBP0I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:26:08 -0500
Message-ID: <4044A692.40106@nortelnetworks.com>
Date: Tue, 02 Mar 2004 10:21:54 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RFC] kbuild: Add a binary only .o file to a module
References: <20040301214617.GA7777@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> Any objections from having this in the kernel?
> [Please, please, this is only for 'legal' binary modules - so do not
> start the usual 'binary modules should be GPL discussion'].
> 
> This is a small step towards better support for external modules.

I'll put in a vote for this.  Unfortunately we have some hardware for 
which the only drivers available use binary blobs.

Chris




-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

