Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262309AbRE2OE4>; Tue, 29 May 2001 10:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262448AbRE2OEq>; Tue, 29 May 2001 10:04:46 -0400
Received: from 216-21-153-1.ip.van.radiant.net ([216.21.153.1]:46866 "HELO
	innerfire.net") by vger.kernel.org with SMTP id <S262309AbRE2OEd>;
	Tue, 29 May 2001 10:04:33 -0400
Date: Tue, 29 May 2001 07:06:20 -0700 (PDT)
From: Gerhard Mack <gmack@innerfire.net>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
cc: Jakob =?iso-8859-1?Q?=D8stergaard?= <jakob@unthought.net>,
        safemode <safemode@voicenet.com>, "G. Hugh Song" <ghsong@kjist.ac.kr>,
        linux-kernel@vger.kernel.org
Subject: Re: Plain 2.4.5 VM...
In-Reply-To: <3B1327D5.6484E61E@mandrakesoft.com>
Message-ID: <Pine.LNX.4.10.10105290705150.9600-100000@innerfire.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> * when you have an active process using ~300M of VM, in a ~380M machine,
> 2/3 of the machine's RAM should -not- be soaked up by cache
> 
> * when you have an active process using ~300M of VM, in a ~380M machine,
> swap should not be full while there is 133M of RAM available.
> 
> The above quoted is top output, taken during the several minutes where
> cc1plus process was ~300M in size.  Similar numbers existed before and
> after my cut-n-paste, so this was not transient behavior.
> 
> I can assure you, these are bugs not features :)
> 
Ive seen that here too but every report I've sent on that has been
dismissed as "that's what it's supposed to do"

--
Gerhard Mack

gmack@innerfire.net

<>< As a computer I find your faith in technology amusing.

