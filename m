Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317888AbSIJSSR>; Tue, 10 Sep 2002 14:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317892AbSIJSRc>; Tue, 10 Sep 2002 14:17:32 -0400
Received: from crack.them.org ([65.125.64.184]:37382 "EHLO crack.them.org")
	by vger.kernel.org with ESMTP id <S317898AbSIJSQk>;
	Tue, 10 Sep 2002 14:16:40 -0400
Date: Tue, 10 Sep 2002 14:21:25 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Frank Peters <frank.peters@intralab.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ptrace probs?
Message-ID: <20020910182125.GA30999@nevyn.them.org>
Mail-Followup-To: Frank Peters <frank.peters@intralab.de>,
	linux-kernel@vger.kernel.org
References: <000d01c258fb$8cf72d40$0242a8c0@alpha.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000d01c258fb$8cf72d40$0242a8c0@alpha.de>
User-Agent: Mutt/1.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 07:54:46PM +0100, Frank Peters wrote:
> Kernel: 2.4.18  
>   
> If I ptrace-Attach to some program I cannot immediately peek values!  
> ( I can but they are all 0) if I insert a sleep(1) after the ATTACH  
> it works?  
>   
> Can somebody explain?  

I don't see any problems here... can you post test code, showing
exactly where something goes wrong?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
