Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261279AbVCEU0V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261279AbVCEU0V (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Mar 2005 15:26:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCEUQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Mar 2005 15:16:59 -0500
Received: from main.gmane.org ([80.91.229.2]:48815 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261187AbVCEUCi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Mar 2005 15:02:38 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Ian Pilcher <i.pilcher@comcast.net>
Subject: Re: [RFQ] Rules for accepting patches into the linux-releases tree
Date: Sat, 05 Mar 2005 14:01:15 -0600
Message-ID: <d0d2sa$h12$1@sea.gmane.org>
References: <20050304222146.GA1686@kroah.com> <20050305135917.GB6373@stusta.de> <20050305174055.GB13104@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: c-24-0-215-208.client.comcast.net
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
In-Reply-To: <20050305174055.GB13104@kroah.com>
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner-SpamScore: s
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Sat, Mar 05, 2005 at 02:59:17PM +0100, Adrian Bunk wrote:
> 
> 
>>An example that doesn't fit:
>>
>>A patch of me to remove an unused function was accepted into 2.6.11 .
>>Today, someone mailed that there's an external GPL'ed module that uses 
>>this function.
>>
>>A patch to re-add this function as it was in 2.6.10 does not fulfill 
>>your criteria, but it is a low-risk way to fix a regression compared to 
>>2.6.10 .
> 
> 
> Yes, I wouldn't have a problem with adding this kind of fix.  Do others
> disagree?
> 

Something about major functional regressions?

-- 
========================================================================
Ian Pilcher                                        i.pilcher@comcast.net
========================================================================

