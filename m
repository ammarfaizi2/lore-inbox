Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261267AbTIWOXi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 10:23:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261293AbTIWOXi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 10:23:38 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:12430 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S261267AbTIWOXg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 10:23:36 -0400
Message-ID: <3F70575C.2090707@nortelnetworks.com>
Date: Tue, 23 Sep 2003 10:23:24 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Tommy Reynolds <reynolds@redhat.com>
Cc: linux-kernel@vger.kernel.org, hpa@zytor.com
Subject: Re: compiler warnings and syscall macros
References: <3F6F6B1B.9040609@nortelnetworks.com> <20030922165104.29176e94.reynolds@redhat.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tommy Reynolds wrote:

> Why not do the obvious:
> 
> 	__sc_ret = -1UL;
> 
> and use a proper constant?


Cause I'm not thinking straight?

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

