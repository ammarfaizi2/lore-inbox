Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262413AbVBXPjd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262413AbVBXPjd (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Feb 2005 10:39:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262419AbVBXPha
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Feb 2005 10:37:30 -0500
Received: from lx09-hrz.uni-duisburg.de ([134.91.4.50]:46555 "EHLO
	lx09-hrz.uni-duisburg.de") by vger.kernel.org with ESMTP
	id S262365AbVBXO47 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Feb 2005 09:56:59 -0500
Message-ID: <421DEB2F.2060209@uni-duisburg.de>
Date: Thu, 24 Feb 2005 15:56:47 +0100
From: =?ISO-8859-1?Q?J=F6rn_Nettingsmeier?= <pol-admin@uni-duisburg.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Olof Johansson <olof@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, nettings@folkwang-hochschule.de
Subject: Re: FUTEX deadlock in ping?
References: <421DA915.7020209@uni-duisburg.de> <20050224144651.GA5702@austin.ibm.com>
In-Reply-To: <20050224144651.GA5702@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olof Johansson wrote:
> On Thu, Feb 24, 2005 at 11:14:45AM +0100, Jörn Nettingsmeier wrote:
> 
> 
>>futex(0x401540f4, FUTEX_WAIT, 2, NULL
>>^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
>>
>>is this one related to the FUTEX problem olof described?
> 
> 
> As bert said, it's likely something else. Is the process killable, and
> does "ps aux" complete? 

yes and yes.

> If so, then this is a different problem.

too bad. i thought i had finally found a clue.. sorry for the noise, and 
many thanks for explaining!

