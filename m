Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289735AbSA3QN2>; Wed, 30 Jan 2002 11:13:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289395AbSA3QNC>; Wed, 30 Jan 2002 11:13:02 -0500
Received: from swazi.realnet.co.sz ([196.28.7.2]:53691 "HELO
	netfinity.realnet.co.sz") by vger.kernel.org with SMTP
	id <S289398AbSA3QLr>; Wed, 30 Jan 2002 11:11:47 -0500
Date: Wed, 30 Jan 2002 18:06:42 +0200 (SAST)
From: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
X-X-Sender: zwane@netfinity.realnet.co.sz
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Michel Angelo da Silva Pereira <michelpereira@uol.com.br>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Oops with 2.4.18-pre3-ac2 with Intel ServerRAID Controller
In-Reply-To: <E16VwfU-0007Xu-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.44.0201301805200.5518-100000@netfinity.realnet.co.sz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 Jan 2002, Alan Cox wrote:

> Ok the oops is not nice. The timeouts point to i2o_scsi and/or the serveraid
> in i2o mode not liking one another (it has an official native mode driver
> too btw which is the one you wanted)

Is that the one supplied on Intel's site? Or is there a kernel supported 
one?

Thanks,
	Zwane Mwaikambo


