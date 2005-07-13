Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262905AbVGMCUI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262905AbVGMCUI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 22:20:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262914AbVGMCUI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 22:20:08 -0400
Received: from main.gmane.org ([80.91.229.2]:61120 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S262905AbVGMCUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 22:20:06 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Anssi Hannula <anssi.hannula@mbnet.fi>
Subject: Re: segmentation fault in TOP command
Date: Wed, 13 Jul 2005 05:07:05 +0300
Message-ID: <42D47749.8000200@mbnet.fi>
References: <dau69d$vit$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-tregw3mdf.dial.inet.fi
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050322)
X-Accept-Language: en-us, en
In-Reply-To: <dau69d$vit$1@sea.gmane.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jose Barroca wrote:
> 
> This one had an interesting output: there was indication of an error
> happening some 197 days ago. I could decipher the remaining info.

This is probably not related.

 > Also,
> the REALLOACTED_SECTOR_CT has a very high number, though it is labelled
> "PRE_FAIL".
> 

But this is; Reallocated sector count above zero indicates a failing 
harddrive.
More information here:
http://smartmontools.sourceforge.net/BadBlockHowTo.txt

If the count is "very high", I think you should get a new harddrive.

-- 
Anssi Hannula

