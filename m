Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289491AbSAOK5Y>; Tue, 15 Jan 2002 05:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289494AbSAOK5O>; Tue, 15 Jan 2002 05:57:14 -0500
Received: from i030-063.nv.iinet.net.au ([203.59.30.63]:62962 "HELO
	aeonline.net") by vger.kernel.org with SMTP id <S289491AbSAOK46>;
	Tue, 15 Jan 2002 05:56:58 -0500
From: crispin@iinet.net.au
Date: Tue, 15 Jan 2002 19:13:05 +0800
To: Horst von Brand <brand@jupiter.cs.uni-dortmund.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Hardwired drivers are going away?
Message-ID: <20020115191305.P1928@earth>
In-Reply-To: <david.lang@digitalinsight.com> <200201151045.g0FAjduU002847@tigger.cs.uni-dortmund.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200201151045.g0FAjduU002847@tigger.cs.uni-dortmund.de>; from brand@jupiter.cs.uni-dortmund.de on Tue, Jan 15, 2002 at 11:45:39AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 15, 2002 at 11:45:39AM +0100, Horst von Brand wrote:
> > On Mon, 14 Jan 2002, Alan Cox wrote:
> 
> > > > 1. security, if you don't need any modules you can disable modules
> > > > entirly and then it's impossible to add a module without patching
> > > > the kernel first (the module load system calls aren't there)
> 
> > > Urban legend.
> 
> > If this is the case then why do I get systemcall undefined error messages
> > when I make a mistake and attempt to load a module on a kernel without
> > modules enabled?
> 
> AFAIU the security improvement of no-modules are way overrated.

insmod knark.o

Crispin
