Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285250AbRLFWRC>; Thu, 6 Dec 2001 17:17:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285255AbRLFWQx>; Thu, 6 Dec 2001 17:16:53 -0500
Received: from mail.reutershealth.com ([204.243.9.36]:34249 "EHLO
	mail.reutershealth.com") by vger.kernel.org with ESMTP
	id <S285250AbRLFWQg>; Thu, 6 Dec 2001 17:16:36 -0500
Message-ID: <3C0FEE80.2050603@reutershealth.com>
Date: Thu, 06 Dec 2001 17:17:36 -0500
From: John Cowan <jcowan@reutershealth.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Horst von Brand <vonbrand@inf.utfsm.cl>
CC: John Stoffel <stoffel@casc.com>, "Eric S. Raymond" <esr@thyrsus.com>,
        linux-kernel@vger.kernel.org, kbuild-devel@lists.sourceforge.net
Subject: Re: [kbuild-devel] Converting the 2.5 kernel to kbuild 2.5
In-Reply-To: <200112061851.fB6IpHE0016176@pincoya.inf.utfsm.cl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst von Brand wrote:

 > I just shudder when thinking that I'll have to learn yet another weird
 > language to be able to hack on Linux... C, gcc-isms with asm() and all, a
 > bit of CML1, now CML2, are OK; and now Python...

You only need to learn Python if you are going to change the
CML2 compiler or interpreter, not if you are just changing
CML2.  You might as well complain that you must learn
Python to hack GNU Mailman.

CML2 hacking requires knowing Python; kernel hacking does not.

-- 
Not to perambulate             || John Cowan <jcowan@reutershealth.com>
    the corridors               || http://www.reutershealth.com
during the hours of repose     || http://www.ccil.org/~cowan
    in the boots of ascension.  \\ Sign in Austrian ski-resort hotel

