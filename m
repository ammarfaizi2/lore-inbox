Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289183AbSAVHL0>; Tue, 22 Jan 2002 02:11:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289182AbSAVHLR>; Tue, 22 Jan 2002 02:11:17 -0500
Received: from pizda.ninka.net ([216.101.162.242]:16309 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S288050AbSAVHK6>;
	Tue, 22 Jan 2002 02:10:58 -0500
Date: Mon, 21 Jan 2002 23:08:56 -0800 (PST)
Message-Id: <20020121.230856.71191773.davem@redhat.com>
To: vherva@niksula.hut.fi
Cc: andrea@suse.de, alan@redhat.com, linux-kernel@vger.kernel.org,
        akpm@zip.com.au, ripperda@nvidia.com, drobbins@gentoo.org
Subject: Re: Athlon PSE/AGP Bug
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020122070517.GK135220@niksula.cs.hut.fi>
In-Reply-To: <20020122013909.N8292@athlon.random>
	<20020121.170822.32749723.davem@redhat.com>
	<20020122070517.GK135220@niksula.cs.hut.fi>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Ville Herva <vherva@niksula.hut.fi>
   Date: Tue, 22 Jan 2002 09:05:18 +0200

   Another case of miscommunication?
   
Yes, Gareth Hughes @ NVIDIA understands very well that this can still
be just a heisenbug.

There is still no hard proof that not using 4M pages really fixes
anything AMD states is wrong with their chips.
