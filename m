Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135403AbRDZNxr>; Thu, 26 Apr 2001 09:53:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135404AbRDZNxh>; Thu, 26 Apr 2001 09:53:37 -0400
Received: from ns.suse.de ([213.95.15.193]:266 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S135403AbRDZNx1>;
	Thu, 26 Apr 2001 09:53:27 -0400
Date: Thu, 26 Apr 2001 15:53:23 +0200
From: Andi Kleen <ak@suse.de>
To: Feng Xian <fxian@fxian.jukie.net>
Cc: Andi Kleen <ak@suse.de>, Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, Feng Xian <fxian@chrysalis-its.com>
Subject: Re: __alloc_pages: 4-order allocation failed
Message-ID: <20010426155323.A20978@gruyere.muc.suse.de>
In-Reply-To: <20010426143012.A18861@gruyere.muc.suse.de> <Pine.LNX.4.30.0104260948210.6474-100000@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.30.0104260948210.6474-100000@tiger>; from fxian@fxian.jukie.net on Thu, Apr 26, 2001 at 09:50:15AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2001 at 09:50:15AM -0400, Feng Xian wrote:
> 
> Yes I am running nvidia module. i tried nv, X use less memory but nv
> doesn't give me the NV_GLX extension, xlock will crash for some 3d mode.

In this case you should report any kernel problems you see to NVidia
first, except if you can also reproduce them without the nvidia module.

-Andi
