Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268787AbUHLVKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268787AbUHLVKD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 17:10:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268786AbUHLVHm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 17:07:42 -0400
Received: from zeus.kernel.org ([204.152.189.113]:46284 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S268787AbUHLVFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 17:05:23 -0400
Date: Thu, 12 Aug 2004 22:47:56 +0200
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       EdHamrick@aol.com
Subject: Re: Consistent complete lock up with 2.6.8-rc2-mm1 and vuescan
Message-ID: <20040812204756.GA12117@gamma.logic.tuwien.ac.at>
References: <20040809185018.GA26084@gamma.logic.tuwien.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20040809185018.GA26084@gamma.logic.tuwien.ac.at>
User-Agent: Mutt/1.3.28i
From: Norbert Preining <preining@logic.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew, hi Ed!

The problem persisted with 2.6.8-rc4-mm1, always (repeatable 100%) after
around 30 scans the computer freezes completely. Not even sysrq works.

But at least what I could check was that it is not a memory problem,
there is still enough swap free (close to 1G).

So what can I do, any ideas?

On Mon, 09 Aug 2004, preining wrote:
> I have a bit of a problem here: I am scanning with vuescan (latest
> version) on linux-2.6.8-rc3-mm1 a lot of images from raw files, i.e.
> only data io from the hard disk, no usb etc interferes, and always after
> 20/30 something images the computer freezes completely. Not even Sysrq
> works. Only reset button. Of course, the syslog shows up nothing.
> 
> Is there anything you two can think of what could be the reason?
> 
> (and no, I have no chance to use serial console, but I doubt it would be
> useful)

Best wishes

Norbert

-------------------------------------------------------------------------------
Norbert Preining <preining AT logic DOT at>         Technische Universität Wien
gpg DSA: 0x09C5B094      fp: 14DF 2E6C 0307 BE6D AD76  A9C0 D2BF 4AA3 09C5 B094
-------------------------------------------------------------------------------
CORSTORPHINE (n.)
A very short peremptory service held in monasteries prior to teatime
to offer thanks for the benediction of digestive biscuits.
			--- Douglas Adams, The Meaning of Liff
