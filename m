Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVAKSa2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVAKSa2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 13:30:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261352AbVAKSa2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 13:30:28 -0500
Received: from gw.unix-scripts.info ([62.212.121.13]:10218 "EHLO
	gw.unix-scripts.info") by vger.kernel.org with ESMTP
	id S261285AbVAKSaM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 13:30:12 -0500
Message-ID: <41E41B32.9070206@apartia.fr>
Date: Tue, 11 Jan 2005 19:30:10 +0100
From: Laurent CARON <lcaron@apartia.fr>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041124)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: Unable to burn DVDs
References: <41E2F823.1070608@apartia.fr> <Pine.LNX.4.61.0501110802180.8535@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0501110802180.8535@yvahk01.tjqt.qr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Engelhardt wrote:

>>Hello,
>>
>>I recently upgraded to 2.6.10 and tried (today) to burn a dvd with growisofs.
>>
>>It seems there is a problem
>>
>>Here is the output
>>
>>
>># growisofs -Z /dev/scd0 -R -J ~/foobar
>>    
>>
>
>I remember ide-scsi being broken now since you can use /dev/hdX directly for 
>writing CDs.
>
>  
>
doesn't work for me

growisofs -Z /dev/hdc -R -J ~/sendmail.mc
:-( unable to open64("/dev/hdc",O_RDONLY): No such device or address

-- 
To give happiness is to deserve happiness.

