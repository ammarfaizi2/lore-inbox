Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267136AbSLKMS3>; Wed, 11 Dec 2002 07:18:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267138AbSLKMS1>; Wed, 11 Dec 2002 07:18:27 -0500
Received: from mail0.epfl.ch ([128.178.50.57]:9489 "HELO mail0.epfl.ch")
	by vger.kernel.org with SMTP id <S267136AbSLKMSY>;
	Wed, 11 Dec 2002 07:18:24 -0500
Message-ID: <3DF72EE2.3050108@epfl.ch>
Date: Wed, 11 Dec 2002 13:26:10 +0100
From: Nicolas ASPERT <Nicolas.Aspert@epfl.ch>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021203
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@suse.de>
CC: Margit Schubert-While <margitsw@t-online.de>, linux-kernel@vger.kernel.org,
       faith@redhat.com, dri-devel@lists.sourceforge.net
Subject: Re: 2.4.20 AGP for I845 wrong ?
References: <fa.jjk71mv.1kja10g@ifi.uio.no> <3DF72A91.5080804@epfl.ch> <20021211132059.C11689@suse.de>
In-Reply-To: <20021211132059.C11689@suse.de>
X-Enigmail-Version: 0.71.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

> I'll check the chipset docs when I get time, and add a comment if
> necessary. No-one seems to be complaining that it isn't working,
> so I'm inclined to believe your diagnosis is correct.
> 

I found the thread of lkml containing the discussion about that ... here 
is the link to the original mail :

http://marc.theaimsgroup.com/?l=linux-kernel&m=102122146829865&w=2

> DRI folks, this seems like duplication given that this data is available
> in agpgart. How about changing this to read whatever agpgart has set in
> .chipset_name ?
> 

Sounds like a good idea to me ;-)

Best regards
Nicolas.
-- 
Nicolas Aspert      Signal Processing Institute (ITS)
Swiss Federal Institute of Technology (EPFL)

