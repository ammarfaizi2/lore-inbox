Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289564AbSA2OnC>; Tue, 29 Jan 2002 09:43:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289629AbSA2Omw>; Tue, 29 Jan 2002 09:42:52 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:43957 "HELO gtf.org")
	by vger.kernel.org with SMTP id <S289564AbSA2Omp>;
	Tue, 29 Jan 2002 09:42:45 -0500
Date: Tue, 29 Jan 2002 09:42:44 -0500
From: Jeff Garzik <garzik@havoc.gtf.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: DervishD <raul@viadomus.com>, ebiederm@xmission.com,
        linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
Message-ID: <20020129094244.F10404@havoc.gtf.org>
In-Reply-To: <20020129093024.E10404@havoc.gtf.org> <E16VZbr-00046x-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <E16VZbr-00046x-00@the-village.bc.nu>; from alan@lxorguk.ukuu.org.uk on Tue, Jan 29, 2002 at 02:51:43PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 02:51:43PM +0000, Alan Cox wrote:
> > Your libc should provide a "sanitized" version of the kernel headers,
> > which is completely separate from any kernel sources.
> > 
> > dietlibc does this...  it's completely independent of kernel header changes.
> > 
> > RedHat will be doing this with glibc in the future.
> 
> We already do. Red Hat shipped since about 7.0 has a seperate set of
> kernel based headers that glibc uses for its own internal use, and the set
> in the kernel sources.

To clarify, Arjan said the headers were going to be further sanitized,
and less just simple copies of selected kernel headers... <cheer>

That's what I wanted to say, but -ENOCAFFEINE :)

	Jeff



