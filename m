Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132497AbRAPTeh>; Tue, 16 Jan 2001 14:34:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132594AbRAPTe1>; Tue, 16 Jan 2001 14:34:27 -0500
Received: from [64.64.109.142] ([64.64.109.142]:19210 "EHLO
	quark.didntduck.org") by vger.kernel.org with ESMTP
	id <S132497AbRAPTeT>; Tue, 16 Jan 2001 14:34:19 -0500
Message-ID: <3A64A214.17FFBBE7@didntduck.org>
Date: Tue, 16 Jan 2001 14:33:40 -0500
From: Brian Gerst <bgerst@didntduck.org>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: en
MIME-Version: 1.0
To: ed@alcpress.com
CC: linux-kernel@vger.kernel.org
Subject: Re: SCSI partitions
In-Reply-To: <3A642C31.25392.4BF2B9@localhost>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ed@alcpress.com wrote:
> 
> Does anyone remember the reason why SCSI drives were limited to
> 15 partitions?

Because of the limitations of having 8-bit major/minor device numbers.

--

				Brian Gerst
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
