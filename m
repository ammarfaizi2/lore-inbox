Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318666AbSHEPi6>; Mon, 5 Aug 2002 11:38:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318669AbSHEPi6>; Mon, 5 Aug 2002 11:38:58 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:786 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318666AbSHEPi5>;
	Mon, 5 Aug 2002 11:38:57 -0400
Message-ID: <3D4E9CE4.8060808@mandrakesoft.com>
Date: Mon, 05 Aug 2002 11:42:28 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Abraham vd Merwe <abraham@2d3d.co.za>
CC: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: ethtool documentation
References: <20020805134657.A12200@crystal.2d3d.co.za>
X-Enigmail-Version: 0.65.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Abraham vd Merwe wrote:
> Hi!
> 
> Is there a document describing the ethtool ioctl's which need to be
> implemented in each ethernet driver?


Unfortunately not.  There is a distinct lack of network driver docs at 
the moment...  The best documentation is looking at source code of 
drivers that implement the most ioctls.

	Jeff


