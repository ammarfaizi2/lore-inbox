Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbTDFOpX (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 10:45:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263003AbTDFOpW (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 10:45:22 -0400
Received: from main.gmane.org ([80.91.224.249]:37784 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S262996AbTDFOpV (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 10:45:21 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Nicholas Wourms <nwourms@myrealbox.com>
Subject: Re: 2.4.21-pre7 and ac97_code.c compilation problem
Date: Sun, 06 Apr 2003 10:52:54 -0400
Message-ID: <3E903F46.9080700@myrealbox.com>
References: <3E8E8AA4.3070302@yahoo.com> <1049560971.25758.4.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@main.gmane.org
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:
> On Sad, 2003-04-05 at 08:49, Lars wrote:
> 
>>It seems prepatch 2.4.21-pre7 changes ac97_codec.c without making
>>matching changes in ac97_codec.h... Just a heads up.
>>
>>The changes to ac97_codec.c are isolated enough so that I could easily
>>reverse that part of the patch to get it to work.
>>
>>I'm not subscribed to this list, please CC me on any responses.
> 
> 
> Marcelo applied a random subset of the changes I sent him. Grab the -ac
> tree
> 

Will you be releasing an -ac patch for pre7?

Cheers,
Nicholas


