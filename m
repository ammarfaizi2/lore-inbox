Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265113AbSJRO6x>; Fri, 18 Oct 2002 10:58:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265120AbSJRO6w>; Fri, 18 Oct 2002 10:58:52 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:65040 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S265113AbSJRO6u>;
	Fri, 18 Oct 2002 10:58:50 -0400
Date: Fri, 18 Oct 2002 08:04:23 -0700
From: Greg KH <greg@kroah.com>
To: Christoph Hellwig <hch@infradead.org>, Crispin Cowan <crispin@wirex.com>,
       "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021018150422.GA6693@kroah.com>
References: <20021017201030.GA384@kroah.com> <20021017211223.A8095@infradead.org> <3DAFB260.5000206@wirex.com> <20021018.000738.05626464.davem@redhat.com> <3DAFC6E7.9000302@wirex.com> <20021018135243.B1670@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021018135243.B1670@infradead.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 01:52:43PM +0100, Christoph Hellwig wrote:
> and btw, as LSM is part of the kernel anyone can and will change it.
> Your LSM team attitude is a bit like that hated CVS mentality..

Please don't assume Crispin's attitude represents anyone but himself.
Not being a kernel developer, he makes statements that occasionally
offend pretty much everyone here (yesterday's gpl issue was a nice
example of that :)

I understand anyone can change the code, and am glad to see that, it
helps everyone out in the end.

thanks,

greg k-h
