Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289813AbSAPCM6>; Tue, 15 Jan 2002 21:12:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289817AbSAPCMs>; Tue, 15 Jan 2002 21:12:48 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:6154 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S289813AbSAPCMk>; Tue, 15 Jan 2002 21:12:40 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] 1-2-3 GB
Date: 15 Jan 2002 18:12:28 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a22nic$2gi$1@cesium.transmeta.com>
In-Reply-To: <20020115090746.B6007@earthlink.net> <20020115184843.D32088@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20020115184843.D32088@suse.de>
By author:    Dave Jones <davej@suse.de>
In newsgroup: linux.dev.kernel
>
> On Tue, Jan 15, 2002 at 09:07:46AM -0500, rwhron@earthlink.net wrote:
>  
>  > The 3 patches in this thread combined into one, with a default
>  > config option of 2GB, and help saying, if unsure, say "1GB":
> 
>  This may be confusing for some, bringing up the question
>  "I'm unsure, but why is the default at 2GB?"
> 
>  Default option should match default advice.
> 

The default should definitely be the one that produces the standard
memory map, i.e. 3 GB userspace.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
