Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262932AbTEBPVl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 11:21:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262933AbTEBPVl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 11:21:41 -0400
Received: from relay03.valueweb.net ([216.219.253.237]:55222 "EHLO
	relay03.valueweb.net") by vger.kernel.org with ESMTP
	id S262932AbTEBPVk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 11:21:40 -0400
Message-ID: <3EB28FC2.6070305@coyotegulch.com>
Date: Fri, 02 May 2003 11:33:22 -0400
From: Scott Robert Ladd <coyote@coyotegulch.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030430 Debian/1.3-5
X-Accept-Language: en
MIME-Version: 1.0
To: John Bradford <john@grabjohn.com>
CC: Bill Davidsen <davidsen@tmr.com>, Hanna Linder <hannal@us.ibm.com>,
       jw schultz <jw@pegasys.ws>, lse-tech@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: LSE conference call
References: <200304251826.h3PIQMNg001890@81-2-122-30.bradfords.org.uk>
In-Reply-To: <200304251826.h3PIQMNg001890@81-2-122-30.bradfords.org.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Bradford wrote:
> Ah, but assuming that you had a compass to calculate the local time
> offset, (ignoring DST), anyway, you could have used that to calculate
> the _local_ time without looking at your watch at all ;-).  However,
> you wouldn't be able to calculate the timezone you were in.

Ah, but if you had a GPS system available, and a database of time zone 
boundaries, you could adjust on-the-fly for different jurisdictions. 
I've dones somethign of the sort recently for a client; the main problem 
lies in the accuracy (and size) of the database. Indiana, for example, 
presents unique challenges, with its patchwork implementation of DST...

-- 
Scott Robert Ladd
Coyote Gulch Productions (http://www.coyotegulch.com)

