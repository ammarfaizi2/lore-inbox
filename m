Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265383AbUBKPNu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Feb 2004 10:13:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265507AbUBKPNu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Feb 2004 10:13:50 -0500
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:20472 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S265383AbUBKPNq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Feb 2004 10:13:46 -0500
Message-ID: <402A46A7.9070302@nortelnetworks.com>
Date: Wed, 11 Feb 2004 10:13:43 -0500
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linux kernel <linux-kernel@vger.kernel.org>
Subject: status of copy-on-write filesystem?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


I'm doing some work where it would simplify things greatly to have 
copy-on-write semantics available.

I've seen overlayfs and the proposed "-union" option for mount,  but 
there doesn't seem to be anything thats really ready for serious use.

Am I missing something?  Is someone working on this?


Thanks,

Chris


-- 
Chris Friesen                    | MailStop: 043/33/F10
Nortel Networks                  | work: (613) 765-0557
3500 Carling Avenue              | fax:  (613) 765-2986
Nepean, ON K2H 8E9 Canada        | email: cfriesen@nortelnetworks.com

