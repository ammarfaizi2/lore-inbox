Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264907AbSLJV6g>; Tue, 10 Dec 2002 16:58:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264910AbSLJV6g>; Tue, 10 Dec 2002 16:58:36 -0500
Received: from ore.jhcloos.com ([64.240.156.239]:30468 "EHLO ore.jhcloos.com")
	by vger.kernel.org with ESMTP id <S264907AbSLJV6g>;
	Tue, 10 Dec 2002 16:58:36 -0500
To: linux1394-devel@lists.sourceforge.net
Cc: linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: [linux-usb-devel] ide-scsi, 1394-sbp2 and usb-storage scsi host ids
References: <m3it0op2dc.fsf@lugabout.jhcloos.org>
From: "James H. Cloos Jr." <cloos@jhcloos.com>
In-Reply-To: <m3it0op2dc.fsf@lugabout.jhcloos.org>
Date: 10 Dec 2002 17:06:05 -0500
Message-ID: <m3of7t1qcy.fsf@lugabout.jhcloos.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "JimC" == James H Cloos <cloos@jhcloos.com> writes:

JimC> In all 2.4 versions I've tested, (the most recent of which are
JimC> 2.4.20-pre4-ac1 and 2.4.20-pre8), ide-scsi, sbp2 and usb-storage
JimC> all use scsi host id 0.

I don't see that I posted an update to this.  In 2.4, this was fixed
at some cset between v2.4.20-pre8 and v2.4.20-rc1.

-JimC

