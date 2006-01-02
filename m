Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751137AbWACAAO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWACAAO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jan 2006 19:00:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWACAAN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jan 2006 19:00:13 -0500
Received: from [81.2.110.250] ([81.2.110.250]:29362 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id S1751139AbWACAAL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jan 2006 19:00:11 -0500
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer compilers
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: gcoady@gmail.com
Cc: Arjan van de Ven <arjan@infradead.org>,
       Antonio Vargas <windenntw@gmail.com>, Andrew Morton <akpm@osdl.org>,
       Adrian Bunk <bunk@stusta.de>, mingo@elte.hu, tim@physik3.uni-rostock.de,
       torvalds@osdl.org, davej@redhat.com, linux-kernel@vger.kernel.org,
       mpm@selenic.com
In-Reply-To: <micjr1lipg2puqbtsocicc37vtfcjbu1jk@4ax.com>
References: <20051229224839.GA12247@elte.hu>
	 <20051230074916.GC25637@elte.hu> <20051231143800.GJ3811@stusta.de>
	 <20051231144534.GA5826@elte.hu> <20051231150831.GL3811@stusta.de>
	 <20060102103721.GA8701@elte.hu> <20060102134228.GC17398@stusta.de>
	 <20060102102824.4c7ff9ad.akpm@osdl.org>
	 <1136227746.2936.46.camel@laptopd505.fenrus.org>
	 <sq7jr1l1ffgdc5ra26ra6n2ota7osj9c2q@4ax.com>
	 <69304d110601021403o59a10c77i3d9ef8dc046e27bd@mail.gmail.com>
	 <1136242584.2839.1.camel@laptopd505.fenrus.org>
	 <micjr1lipg2puqbtsocicc37vtfcjbu1jk@4ax.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Mon, 02 Jan 2006 23:57:53 +0000
Message-Id: <1136246274.8570.24.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2006-01-03 at 10:10 +1100, Grant Coady wrote:
> >+There appears to be a common misperception that gcc has a magic "make me
> >+faster" ricing option called "inline". While the use of inlines can be
>           ^^^^^^--?? not sure what this is

American car kiddy slang. Not appropriate for internationally read
documentation. Think "go faster stripes" etc.

Alan

