Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262004AbVBPLPH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262004AbVBPLPH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Feb 2005 06:15:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262005AbVBPLPH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Feb 2005 06:15:07 -0500
Received: from ptb-relay01.plus.net ([212.159.14.212]:59145 "EHLO
	ptb-relay01.plus.net") by vger.kernel.org with ESMTP
	id S262004AbVBPLPC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Feb 2005 06:15:02 -0500
Message-ID: <42132B31.7010503@dsvr.net>
Date: Wed, 16 Feb 2005 11:14:57 +0000
From: Jonathan Sambrook <jonathan@dsvr.net>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Klaus Muth <muth@hagos.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: kernel panic with 2.4.26
References: <200501210715.03716.muth@hagos.de> <200502111015.54681.muth@hagos.de>
In-Reply-To: <200502111015.54681.muth@hagos.de>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Klaus Muth wrote:
> Am Freitag, 21. Januar 2005 07:15 schrieb Klaus Muth:
> 
>>Every now and then (maybe twice a week) my server panics. [...]
>>Any help will be appreciated.
> 
> 
> Did help myself. Seems to work.
> 
> 
>>ksymoops 2.4.5 on i686 2.4.26-msi1.  Options used
> 
> 
> Updated to 2.4.29, keeping my kernel config. No panic since then (2 weeks) 
> which seems to be a drastic decrease of the panics/week ratio ;).

Sorry, didn't spot your previous email.

I've not set aside time to investigate further, but turning HT off made 
the problem go away. Would be interested to hear further reports.

Regards,
Jonathan

