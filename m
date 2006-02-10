Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932238AbWBJXxc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932238AbWBJXxc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 18:53:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbWBJXxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 18:53:32 -0500
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:5608 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP id S932238AbWBJXxb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 18:53:31 -0500
Subject: Re: CD-blanking leads to machine freeze with current -git [was:
	Re: CD writing in future Linux try #2 [ was: Re: CD writing in future Linux
	(stirring up a hornets' nest) ]]
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Marc Koschewski <marc@osknowledge.org>
Cc: Phillip Susi <psusi@cfl.rr.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20060210234121.GC5713@stiffy.osknowledge.org>
References: <58cb370e0601270837h61ac2b03uee84c0fa9a92bc28@mail.gmail.com>
	 <20060210175848.GA5533@stiffy.osknowledge.org>
	 <43ECE734.5010907@cfl.rr.com>
	 <20060210210006.GA5585@stiffy.osknowledge.org>
	 <1139613834.14383.5.camel@localhost.localdomain>
	 <20060210234121.GC5713@stiffy.osknowledge.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Fri, 10 Feb 2006 23:56:12 +0000
Message-Id: <1139615772.14383.8.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2006-02-11 at 00:41 +0100, Marc Koschewski wrote:
> I'm also curious when DELL will release their first mobile with SCSI onboard
> instead of IDE. The chips are the same size... 

SCSI I think is dead, but SATA is normally one device per bus so the
problem goes away

> Thanks anyone for clarification. There's still sooo much to learn. But the code
> is here and I'll try to do my very best... ;)


The magic cdrecord option is "-immed"


