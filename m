Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289406AbSAJUPZ>; Thu, 10 Jan 2002 15:15:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289656AbSAJUPP>; Thu, 10 Jan 2002 15:15:15 -0500
Received: from a178d15hel.dial.kolumbus.fi ([212.54.8.178]:61748 "EHLO
	porkkala.jlaako.pp.fi") by vger.kernel.org with ESMTP
	id <S289406AbSAJUPB>; Thu, 10 Jan 2002 15:15:01 -0500
Message-ID: <3C3DF5EE.33762724@kolumbus.fi>
Date: Thu, 10 Jan 2002 22:13:34 +0200
From: Jussi Laako <jussi.laako@kolumbus.fi>
X-Mailer: Mozilla 4.79 [en] (Windows NT 5.0; U)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
In-Reply-To: <E16OUu0-00035o-00@the-village.bc.nu> <200201101753.g0AHrlA17591@snark.thyrsus.com> <3C3DDEA9.E8FAB8DC@nortelnetworks.com> <20020110203655.H5235@khan.acc.umu.se> <3C3DF2DE.2316D13E@nortelnetworks.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Friesen wrote:
> 
> machine.  Other possibilities would be running a kernel compile, a 
> recursive search for specific file content through the entire filesystem, 
> or anything else that is likely to cause problems. It might even be 
> someone else in the house logged into it and running stuff over the 
> network.

It's not enjoyable late night DVD watching when updatedb fires up at middle
of the movie. Nor when you are trying to record some audio to the disk.
Vanilla kernel really chokes up on those situations. Lowlatency patches help
a lot on this.


 - Jussi Laako

-- 
PGP key fingerprint: 161D 6FED 6A92 39E2 EB5B  39DD A4DE 63EB C216 1E4B
Available at PGP keyservers

