Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263091AbSJDSGY>; Fri, 4 Oct 2002 14:06:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263093AbSJDSGX>; Fri, 4 Oct 2002 14:06:23 -0400
Received: from zcars04e.nortelnetworks.com ([47.129.242.56]:51169 "EHLO
	zcars04e.ca.nortel.com") by vger.kernel.org with ESMTP
	id <S263091AbSJDSGX>; Fri, 4 Oct 2002 14:06:23 -0400
Message-ID: <3D9DD9E5.5080402@nortelnetworks.com>
Date: Fri, 04 Oct 2002 14:11:49 -0400
X-Sybari-Space: 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/net/bootpc support for non-ASCII vendor specific tags?
References: <3D9DCD22.4070205@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Friesen, Christopher [CAR:7Q26:EXCH] wrote:

> Assuming that binary information is allowable, would a patch printing 
> out tags 128-254 of the vendor specific information as raw hex 
> characters be considered acceptable/useful?

Bah...I just realized I can use hexdump to get the raw data.  Sorry to 
bother you all, return to your regularly scheduled activities.



