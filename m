Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263918AbTKJPgi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 10:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263920AbTKJPgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 10:36:38 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:10969 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S263918AbTKJPgh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 10:36:37 -0500
Message-ID: <3FAFB081.3090900@nortelnetworks.com>
Date: Mon, 10 Nov 2003 10:36:33 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: syscall numbers larger than 255?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Just a quick and simple question for someone that knows the answer.

Stock 2.4.20 for i386 uses syscalls up to 252.  I want to add about a 
half-dozen new syscalls (forward porting stuff that we've got on 2.4.18).

Does x86 support syscall numbers > 255?  If yes, do I have to do 
anything special to use them? If not, what are my options?

Thanks,

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

