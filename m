Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVFDMZg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVFDMZg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Jun 2005 08:25:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261337AbVFDMZg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Jun 2005 08:25:36 -0400
Received: from hulk.hostingexpert.com ([69.57.134.39]:24502 "EHLO
	hulk.hostingexpert.com") by vger.kernel.org with ESMTP
	id S261336AbVFDMZa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Jun 2005 08:25:30 -0400
Message-ID: <42A19DBE.3080403@m1k.net>
Date: Sat, 04 Jun 2005 08:25:34 -0400
From: Michael Krufky <mkrufky@m1k.net>
Reply-To: mkrufky@m1k.net
User-Agent: Mozilla Thunderbird 1.0.2 (Windows/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org>
In-Reply-To: <20050603163843.1cf5045d.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - hulk.hostingexpert.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - m1k.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:

>My things-to-worry-about folder still has 244 entries.  Nobody seems to
>care much.  Poor me.
>
>Subject: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port
>  
>

>Subject: Re: 2.6.12-rc5-mm1 breaks serio: i8042 AUX port
>
These are both from the same thread -- I reported the issue.  I was 
having this problem in -mm1, and I'm intermittently having the problem 
in -mm2 ... I'm starting to think there may be another factor involved 
(I can't imagine what) ... But if I am the only person seeing this 
issue, then I wouldn't worry about this.  I'll do more testing when -mm3 
comes out and I'll post as to whether the problem is still present or not.

-- 
Michael Krufky

