Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264151AbTDOXGW (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 19:06:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264152AbTDOXGW 
	(for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 19:06:22 -0400
Received: from ca-fulrtn-cuda2-c6a-113.anhmca.adelphia.net ([68.66.9.113]:6545
	"EHLO shrike.mirai.cx") by vger.kernel.org with ESMTP
	id S264151AbTDOXGT (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 19:06:19 -0400
Message-ID: <3E9C9332.3000204@tmsusa.com>
Date: Tue, 15 Apr 2003 16:18:10 -0700
From: J Sloan <joe@tmsusa.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mads Christensen <mfc@krycek.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: named problems!
References: <1050440553.10001.2.camel@krycek>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had this issue but after commenting out
the BSD_COMPAT line from the headers
then rebuilding and reinstalling the bind
rpms, the messages no longer occur -

Joe

Mads Christensen wrote:

>Hey kernel guys!
>
>I know this issue has been delt with (google) but did you ever reach to
>a fix?
>
>Apr 15 22:56:03 krycek kernel: process `rndc' is using obsolete
>setsockopt SO_BSDCOMPAT
>
>Thx in advance
>  
>


