Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264296AbTL3UOF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 15:14:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265905AbTL3UOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 15:14:05 -0500
Received: from mx1.it.wmich.edu ([141.218.1.89]:64673 "EHLO mx1.it.wmich.edu")
	by vger.kernel.org with ESMTP id S264296AbTL3UOC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 15:14:02 -0500
Message-ID: <3FF1DC88.9040806@wmich.edu>
Date: Tue, 30 Dec 2003 15:14:00 -0500
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric D. Mudama" <edmudama@mail.bounceswoosh.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Is it safe to ignore UDMA BadCRC errors?
References: <16368.20794.147453.255239@jik.kamens.brookline.ma.us> <20031229195235.GC26821@bounceswoosh.org> <16369.25514.425834.153361@jik.kamens.brookline.ma.us> <20031230200643.GC6992@bounceswoosh.org>
In-Reply-To: <20031230200643.GC6992@bounceswoosh.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric D. Mudama wrote:
> On Tue, Dec 30 at  6:38, Jonathan Kamens wrote:
> 
>> I replaced the cable with a brand new one and I'm still getting the
>> CRC errors.  What now?
> 
> 
> Do you know if you're doing reads or writes when the errors occur?
> 
> What motherboard/chipset are you using with this drive?
> 
> Is the environment especially warm?
> 

CRC errors can easily be caused by the cable being close to a magnet or 
high electricity source.   Watch out for the case speaker and any other 
speakers around the cable.  Also, make sure you're using S.M.A.R.T to 
check the drive, itself, for problems.

