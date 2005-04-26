Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261495AbVDZUQ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVDZUQ5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 16:16:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261774AbVDZUOv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 16:14:51 -0400
Received: from gprs189-60.eurotel.cz ([160.218.189.60]:43438 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261772AbVDZUOf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 16:14:35 -0400
Date: Tue, 26 Apr 2005 22:14:11 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hch@infradead.org, jamie@shareable.org, linuxram@us.ibm.com,
       7eggert@gmx.de, bulb@ucw.cz, viro@parcelfarce.linux.theplanet.co.uk,
       linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
       akpm@osdl.org
Subject: Re: [PATCH] private mounts
Message-ID: <20050426201411.GA20109@elf.ucw.cz>
References: <1114445923.4480.94.camel@localhost> <20050425191015.GC28294@mail.shareable.org> <E1DQMB0-00008a-00@dorka.pomaz.szeredi.hu> <20050426091921.GA29810@infradead.org> <E1DQMGZ-00009n-00@dorka.pomaz.szeredi.hu> <20050426093628.GA30208@infradead.org> <E1DQMYu-0000DL-00@dorka.pomaz.szeredi.hu> <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > Could we get root-only fuse in, please?
> 
> chmod u-s /usr/bin/fusermount

:-)))). I meant merging patches that are not controversial into
mainline. AFAICT only controversial pieces are "make it safe for
non-root users"...

							Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.
