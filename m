Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265433AbTFMQZz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jun 2003 12:25:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265434AbTFMQZz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jun 2003 12:25:55 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:2722 "EHLO
	zcars04e.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265433AbTFMQZx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jun 2003 12:25:53 -0400
Message-ID: <3EE9FE49.2090905@nortelnetworks.com>
Date: Fri, 13 Jun 2003 12:39:37 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Joe <joeja@mindspring.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Xeon  processors &&Hyper-Threading
References: <3EE9FDFA.6020803@mindspring.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe wrote:

> I'm not asking if Linux can RUN the Xeon processor.
> 
> I'm asking if Linux processor takes any advantage of the Hyper-Threading 
> built into this processor?

The kernel has full support for hyperthreading.  Be aware however that it 
doesn't always buy you any performance gain and can actually result in 
performance decrease.

Chris

-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

