Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267470AbTA3KbH>; Thu, 30 Jan 2003 05:31:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267471AbTA3KbH>; Thu, 30 Jan 2003 05:31:07 -0500
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:29317
	"EHLO irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S267470AbTA3KbG>; Thu, 30 Jan 2003 05:31:06 -0500
Subject: Re: sys_sendfile64 not in Linux 2.4.21-pre4
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Christoph Hellwig <hch@infradead.org>
Cc: John Fremlin <vii@users.sourceforge.net>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       lkml <linux-kernel@vger.kernel.org>, cw@f00f.org, bcrl@redhat.com
In-Reply-To: <20030130082922.A22879@infradead.org>
References: <Pine.LNX.4.53L.0301290143350.27119@freak.distro.conectiva>
	 <86of5z5ur1.fsf@notus.ireton.fremlin.de>
	 <20030130082922.A22879@infradead.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1043926388.28133.16.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-2) 
Date: 30 Jan 2003 11:33:09 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-01-30 at 08:29, Christoph Hellwig wrote:
> On Thu, Jan 30, 2003 at 12:47:14AM +0000, John Fremlin wrote:
> > 
> > Why isn't sendfile64 included in 2.4.21-pre4? glibc 2.3 already
> > expects it, so programs with 64-bit off_t will not be able to use
> > sendfile otherwise. And the patch is IIUC very small . . .
> 
> I sent patches to Marcelo a few times, but they got silently ignored..

Can you forward me a copy ?

