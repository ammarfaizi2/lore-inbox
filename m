Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965138AbVINJ6P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965138AbVINJ6P (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 05:58:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965134AbVINJ6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 05:58:15 -0400
Received: from wscnet.wsc.cz ([212.80.64.118]:30599 "EHLO wscnet.wsc.cz")
	by vger.kernel.org with ESMTP id S965131AbVINJ6N (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 05:58:13 -0400
Message-ID: <4327F41B.6080008@gmail.com>
Date: Wed, 14 Sep 2005 11:57:47 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: cs, en-us, en
MIME-Version: 1.0
To: Timothy Thelin <Timothy.Thelin@wdc.com>
CC: James Bottomley <James.Bottomley@SteelEye.com>,
       Mike Christie <michaelc@cs.wisc.edu>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [RESEND][PATCH 2.6.14-rc1] scsi: sd, sr, st, and scsi_lib all
 fail to copy cmd_len to new cmd
References: <CA45571DE57E1C45BF3552118BA92C9D69BDE9@WDSCEXBECL03.sc.wdc.com>
In-Reply-To: <CA45571DE57E1C45BF3552118BA92C9D69BDE9@WDSCEXBECL03.sc.wdc.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Timothy Thelin napsal(a):

>Sorry it wrapped.  It's now an attachment.
>
>This fixes an issue in scsi command initialization from a request
>where sd, sr, st, and scsi_lib all fail to copy the request's
>cmd_len to the scsi command's cmd_len field.
>
>Signed-off-by: Timothy Thelin <timothy.thelin@wdc.com>
>  
>
Mime is hell, include patch in e-mail's body, please.

thanks,

-- 
Jiri Slaby         www.fi.muni.cz/~xslaby
~\-/~      jirislaby@gmail.com      ~\-/~
241B347EC88228DE51EE A49C4A73A25004CB2A10

