Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318369AbSHWHBm>; Fri, 23 Aug 2002 03:01:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318447AbSHWHBm>; Fri, 23 Aug 2002 03:01:42 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:14859 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S318369AbSHWHBl>; Fri, 23 Aug 2002 03:01:41 -0400
Message-ID: <3D65DF4D.68EEA449@aitel.hist.no>
Date: Fri, 23 Aug 2002 09:07:57 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.31 i686)
X-Accept-Language: no, en, en
MIME-Version: 1.0
To: Jesper Juhl <jju@dif.dk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Problem determining number of CPUs
References: <20BF5713E14D5B48AA289F72BD372D6821CBA0@AUSXMPC122.aus.amer.dell.com> <1029940635.7255.185.camel@jju_lnx.backbone.dif.dk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesper Juhl wrote:

> In the case of 4 HT capable CPU's it could be reported like
> 
> 8 CPUs (4 physical)
> 
Or 8 CPUs (4 chips) 
2 cpus on a chip may be counterintuitive to some, but there
isn't anything special about it.  They aren't really 
less "physical".

Helge Hafting
