Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261753AbVDOHZC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261753AbVDOHZC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 03:25:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVDOHZB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 03:25:01 -0400
Received: from smtp1.netcologne.de ([194.8.194.112]:5037 "EHLO
	smtp1.netcologne.de") by vger.kernel.org with ESMTP id S261753AbVDOHY7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 03:24:59 -0400
Message-ID: <425F6C48.9060505@interia.pl>
Date: Fri, 15 Apr 2005 09:24:56 +0200
From: Tomasz Chmielewski <mangoo@interia.pl>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wright <chrisw@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: poor SATA performance under 2.6.11 (with < 2.6.11 is OK)?
References: <425E9902.8000804@interia.pl> <20050414165535.GA15440@irc.pl> <425EE9CF.4030202@interia.pl> <20050414223417.GA23013@shell0.pdx.osdl.net>
In-Reply-To: <20050414223417.GA23013@shell0.pdx.osdl.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wright wrote:
> * Tomasz Chmielewski (mangoo@interia.pl) wrote:
> 
>>or should I wait for 2.6.11.7 (?), where it should be corrected?

well, indeed, a week ago or more :)


> Wait, no longer, 2.6.11.7 has been here already ;-)  However, nothing in
> this area was touched.  If there's an outstanding issue, please chase it
> down, and if it's reasonable regression fix we can consider it for
> the -stable tree.

OK so Tomasz Torch suggested that my drive was blacklisted somewhere 
after 2.6.8.1 (it's the last kernel on which I have good performance).

Does drive blacklisting = very poor performance?
And no drive blacklisting = good performance, and possibly data corruption?


Tomek
