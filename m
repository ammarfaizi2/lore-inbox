Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267866AbTAHVQD>; Wed, 8 Jan 2003 16:16:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267878AbTAHVQD>; Wed, 8 Jan 2003 16:16:03 -0500
Received: from NODE1.HOSTING-NETWORK.COM ([66.216.16.1]:56841 "HELO
	hosting-network.com") by vger.kernel.org with SMTP
	id <S267866AbTAHVQC>; Wed, 8 Jan 2003 16:16:02 -0500
X-Comments: BlackMail headers - Mail to abuse@featureprice.com to report spam.
X-Authenticated-Connect: 216.142.75.231
X-Authenticated-Timestamp: 16:20:58(EST) on January 08, 2003
X-HELO-From: epunjabis.com
X-Mail-From: <vish@epunjabis.com>
X-Sender-IP-Address: 216.142.75.231
Message-ID: <3E1C6CF2.9090308@epunjabis.com>
Date: Wed, 08 Jan 2003 13:24:50 -0500
From: Vishal Verma <vish@epunjabis.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: Virtual WORM device
References: <200301071841.h07If7QJ002323@darkstar.example.net>
In-Reply-To: <200301071841.h07If7QJ002323@darkstar.example.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Another possibility would be to create a meta-device that works like a
> cross between the loopback device, and WORM device, I.E. start at the
> begining, and allocate sectors sequentially.  Whenever a sector would
> normally be overwritten, a new one is allocated instead.  This way,
> you could always access the filesystem as it was at any mount in time.

OR you can check-in your entire filesystem into CVS ;)

