Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318514AbSH1CNK>; Tue, 27 Aug 2002 22:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318516AbSH1CNK>; Tue, 27 Aug 2002 22:13:10 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:1681 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S318514AbSH1CNJ>;
	Tue, 27 Aug 2002 22:13:09 -0400
Date: Tue, 27 Aug 2002 22:17:29 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Arador <diegocg@teleline.es>
cc: us15@os.inf.tu-dresden.de, linux-kernel@vger.kernel.org
Subject: Re: Linux v2.5.32
In-Reply-To: <20020828032142.5a218b08.diegocg@teleline.es>
Message-ID: <Pine.GSO.4.21.0208272214200.6084-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wed, 28 Aug 2002, Arador wrote:

> This is the expected behaviour under stable kernels
> 
> hdc: 78165360 sectors (40021 MB) w/2048KiB Cache, CHS=77545/16/63
>  hdc: [DM6:DDO] [remap +63] [4865/255/63] hdc1 < hdc5 hdc6 hdc7 > hdc2 hdc3

DM6 et.al. support had been removed (by aeb? not sure).  Check in archives
who it was and talk to them - it's not only common to 2.5.32 with and without
fixes, it's common to 2.5.32 and 2.5.31 (with Andre/Jens and Martin's versions
of driver resp.)

