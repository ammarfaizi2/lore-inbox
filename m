Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268566AbUHLNnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268566AbUHLNnO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 09:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268559AbUHLNnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 09:43:13 -0400
Received: from mta8.srv.hcvlny.cv.net ([167.206.5.75]:10948 "EHLO
	mta8.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S268568AbUHLNnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 09:43:05 -0400
Date: Thu, 12 Aug 2004 09:43:03 -0400
From: Nathan Bryant <nbryant@optonline.net>
Subject: Re: [PATCH] SCSI midlayer power management
In-reply-to: <1092303123.3214.3.camel@laptop.cunninghams>
To: ncunningham@linuxmail.org
Cc: Pavel Machek <pavel@ucw.cz>,
       "'James Bottomley'" <James.Bottomley@steeleye.com>,
       Linux SCSI Reflector <linux-scsi@vger.kernel.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com
Message-id: <411B73E7.6050901@optonline.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040803
References: <4119611D.60401@optonline.net> <20040811080935.GA26098@elf.ucw.cz>
 <411A1B72.1010302@optonline.net> <1092262602.3553.14.camel@laptop.cunninghams>
 <411AA24C.6050303@optonline.net> <1092303123.3214.3.camel@laptop.cunninghams>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

>The host adapter isn't in the device's chain of parents?
>
It does seem to be, if you look in sysfs. Ok maybe I'm pointing out the 
obvious ;)
