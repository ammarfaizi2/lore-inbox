Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVA0Pq6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVA0Pq6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 10:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262646AbVA0Pq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 10:46:58 -0500
Received: from relay1.tiscali.de ([62.26.116.129]:55184 "EHLO
	webmail.tiscali.de") by vger.kernel.org with ESMTP id S262645AbVA0Pqx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 10:46:53 -0500
Message-ID: <41F9290E.1050209@tiscali.de>
Date: Thu, 27 Jan 2005 17:46:54 +0000
From: Matthias-Christian Ott <matthias.christian@tiscali.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050108)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Chris Wedgwood <cw@f00f.org>
CC: Steve Lord <lord@xfs.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Preempt & Xfs Question
References: <41F91470.6040204@tiscali.de> <41F908C4.4080608@xfs.org> <20050127154017.GA12493@taniwha.stupidest.org>
In-Reply-To: <20050127154017.GA12493@taniwha.stupidest.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Wedgwood wrote:

>>BUG: using smp_processor_id() in preemptible [00000001] code:
>>khelper/892
>>    
>>
>
>fixed in CVS, I guess it will hit mainline soon
>
>  
>
How did you fix it?

Matthias-Christian Ott

-- 
http://unixforge.org/~matthias-christian-ott/

