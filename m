Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261665AbSJUVM1>; Mon, 21 Oct 2002 17:12:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261662AbSJUVM0>; Mon, 21 Oct 2002 17:12:26 -0400
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:15625 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S261665AbSJUVMU>;
	Mon, 21 Oct 2002 17:12:20 -0400
Date: Mon, 21 Oct 2002 14:17:22 -0700
From: Greg KH <greg@kroah.com>
To: Crispin Cowan <crispin@wirex.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Christoph Hellwig <hch@infradead.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-security-module@wirex.com
Subject: Re: [PATCH] remove sys_security
Message-ID: <20021021211721.GB924@kroah.com>
References: <20021017195015.A4747@infradead.org> <20021017185352.GA32537@kroah.com> <20021017195838.A5325@infradead.org> <20021017190723.GB32537@kroah.com> <20021017210402.A7741@infradead.org> <20021017201030.GA384@kroah.com> <1035208643.27309.109.camel@irongate.swansea.linux.org.uk> <3DB46DD2.8030007@wirex.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB46DD2.8030007@wirex.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 02:12:50PM -0700, Crispin Cowan wrote:
> 
> Therefore, the sys_security syscall has been removed.

Um, removed in what tree?  Still looks like it's present in 2.5.44 :)

Ok, I'll add Christoph's patch to my other LSM hook rework patches and
queue them up for when Linus gets back from vacation.

thanks,

greg k-h
