Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268381AbUHQSYc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268381AbUHQSYc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Aug 2004 14:24:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268382AbUHQSYb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Aug 2004 14:24:31 -0400
Received: from s0003.shadowconnect.net ([213.239.201.226]:40837 "EHLO
	mail.shadowconnect.com") by vger.kernel.org with ESMTP
	id S268381AbUHQSYa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Aug 2004 14:24:30 -0400
Message-ID: <4122507A.3070500@shadowconnect.com>
Date: Tue, 17 Aug 2004 20:37:46 +0200
From: Markus Lidel <Markus.Lidel@shadowconnect.com>
User-Agent: Mozilla Thunderbird 0.6 (Windows/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Warren Togami <wtogami@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Merge I2O patches from -mm
References: <411F37CC.3020909@redhat.com> <20040817125303.A21238@infradead.org> <412208A6.7020104@shadowconnect.com> <20040817175624.A24038@infradead.org>
In-Reply-To: <20040817175624.A24038@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Christoph Hellwig wrote:
> The patch below adds a __scsi_add_device that can "preload" sdev->hostdata.

Thank you very much for changing it!

At the moment i only have a patch without the i2o_scsi changes, but that 
will follow ASAP...



Best regards,


Markus Lidel
------------------------------------------
Markus Lidel (Senior IT Consultant)

Shadow Connect GmbH
Carl-Reisch-Weg 12
D-86381 Krumbach
Germany

Phone:  +49 82 82/99 51-0
Fax:    +49 82 82/99 51-11

E-Mail: Markus.Lidel@shadowconnect.com
URL:    http://www.shadowconnect.com
