Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264904AbUENMVQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264904AbUENMVQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 08:21:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265265AbUENMVQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 08:21:16 -0400
Received: from mail.gmx.net ([213.165.64.20]:31427 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264904AbUENMVP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 08:21:15 -0400
X-Authenticated: #4512188
Message-ID: <40A4B9BB.3080803@gmx.de>
Date: Fri, 14 May 2004 14:21:15 +0200
From: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040504)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: libata and write cache
References: <40A3962F.3020500@pacbell.net> <40A47AC3.4010403@gmx.de>
In-Reply-To: <40A47AC3.4010403@gmx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am just wondering how to enable write back caching with libata.

dmesg gives me

SCSI device sda: drive cache: write through

I would like to use the drive's wirte caching feature to improve 
performance /I know it is a bit dangerous with a flaky system).

Could anyeone tell me how to do it?

Thanks,

Prakash
