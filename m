Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288923AbSA2HyB>; Tue, 29 Jan 2002 02:54:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288925AbSA2Hxw>; Tue, 29 Jan 2002 02:53:52 -0500
Received: from 12-224-37-81.client.attbi.com ([12.224.37.81]:4626 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S288923AbSA2Hxr>;
	Tue, 29 Jan 2002 02:53:47 -0500
Date: Mon, 28 Jan 2002 23:52:45 -0800
From: Greg KH <greg@kroah.com>
To: Rob Landley <landley@trommello.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: A modest proposal -- We need a patch penguin
Message-ID: <20020129075245.GA15419@kroah.com>
In-Reply-To: <Pine.LNX.4.33.0201282153160.10900-100000@penguin.transmeta.com> <200201290732.g0T7WRU02551@snark.thyrsus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200201290732.g0T7WRU02551@snark.thyrsus.com>
User-Agent: Mutt/1.3.26i
X-Operating-System: Linux 2.2.20 (i586)
Reply-By: Tue, 01 Jan 2002 05:41:53 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 29, 2002 at 02:33:24AM -0500, Rob Landley wrote:
> 
> I'm not proposing replacing the current subsystem maintainers.  But are the 
> current subsystem maintainers happy?

I'll speak up here as a subsystem maintainer and say that I'm happy with
the current situation.  I integrate a wide variety of USB driver patches
from lots of different people (and usually in lots of different formats
against different kernel trees) and feed them to Linus/Marcelo/Alan in
small chunks that can be easily applied against their latest kernel
version. 

Sure, sometimes my patches get dropped, but you forgot to mention the
most important thing a kernel programmer needs to have, persistence :)

thanks,

greg k-h
