Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264443AbUGFU4t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264443AbUGFU4t (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Jul 2004 16:56:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264519AbUGFU4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Jul 2004 16:56:07 -0400
Received: from wsip-68-99-153-203.ri.ri.cox.net ([68.99.153.203]:1968 "EHLO
	blue-labs.org") by vger.kernel.org with ESMTP id S264443AbUGFUxq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Jul 2004 16:53:46 -0400
Message-ID: <40EB1181.40406@blue-labs.org>
Date: Tue, 06 Jul 2004 16:54:25 -0400
From: David Ford <david+challenge-response@blue-labs.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.8a2) Gecko/20040706
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tim Berti <tim@tsearch.com>
CC: netdev@oss.sgi.com, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fix tcp_default_win_scale.
References: <828E111C7AEF60468FAA5FBC696DD80F67DF37@64-3-142-15.dia.xo.com>
In-Reply-To: <828E111C7AEF60468FAA5FBC696DD80F67DF37@64-3-142-15.dia.xo.com>
Content-Type: multipart/mixed;
 boundary="------------060300030605010502050107"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------060300030605010502050107
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

By recruiting someone with enough of a technology clue to scroll to the 
bottom of the message and read: "To unsubscribe from ...."

:P

David
p.s. and I wonder why I have so little faith in marketing and HR.

Tim Berti wrote:

>How do i get off this list?
>
>Tim Berti 
>Senior Recruiter 
>TECHNOLOGY SEARCH INTERNATIONAL 
>1737 North First Street, Suite 600 
>San Jose, CA. 95112 
>http://www.tsearch.com 
>Email: tim@tsearch.com 
>Phone: 408-437-9500 Ext. 303 
>
>
>
>-----Original Message-----
>From: Stephen Hemminger [mailto:shemminger@osdl.org]
>Sent: Tuesday, July 06, 2004 1:37 PM
>To: David S. Miller
>Cc: jamie@shareable.org; netdev@oss.sgi.com; linux-net@vger.kernel.org;
>linux-kernel@vger.kernel.org
>Subject: Re: [PATCH] fix tcp_default_win_scale.
>
>
>On Tue, 6 Jul 2004 13:28:22 -0700
>"David S. Miller" <davem@redhat.com> wrote:
>
>  
>
>>On Tue, 6 Jul 2004 13:05:49 -0700
>>Stephen Hemminger <shemminger@osdl.org> wrote:
>>
>>    
>>
>>>On Tue, 6 Jul 2004 20:40:34 +0100
>>>Jamie Lokier <jamie@shareable.org> wrote:
>>>
>>>      
>>>
>>>>Are you saying there are broken firewalls which strip TCP options in
>>>>one direction only?
>>>>        
>>>>
>>>It appears so.
>>>      
>>>
>>Ok, this is a possibility.  And why it breaks is that if the ACK
>>for the SYN+ACK comes back, the SYN+ACK sender can only assume
>>that the window scale was accepted.
>>
>>Stephen, do you have a trace showing exactly this?
>>    
>>
>
>No, I don't have a br0ken firewall here.  I can get out fine.
>When I setup with same kernel as packages.gentoo.org, it works fine as well.
>-
>To unsubscribe from this list: send the line "unsubscribe linux-net" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>  
>

--------------060300030605010502050107
Content-Type: text/x-vcard; charset=utf-8;
 name="david+challenge-response.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="david+challenge-response.vcf"

begin:vcard
fn:David Ford
n:Ford;David
email;internet:david@blue-labs.org
title:Industrial Geek
tel;home:Ask please
tel;cell:(203) 650-3611
x-mozilla-html:TRUE
version:2.1
end:vcard


--------------060300030605010502050107--
