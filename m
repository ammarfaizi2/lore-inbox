Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129050AbQKHLxh>; Wed, 8 Nov 2000 06:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129057AbQKHLx1>; Wed, 8 Nov 2000 06:53:27 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:49397 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S129050AbQKHLxS>; Wed, 8 Nov 2000 06:53:18 -0500
Date: Wed, 8 Nov 2000 12:52:58 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Gerst <bgerst@didntduck.org>, forop066@zaz.com.br,
        linux-kernel@vger.kernel.org
Subject: Re: Calling module symbols from inside the kernel !
Message-ID: <20001108125258.N7204@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3A070BEF.7712DEDB@didntduck.org> <200011061924.QAA31314@srv1-for.for.zaz.com.br> <3A070BEF.7712DEDB@didntduck.org> <13979.973608102@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <13979.973608102@redhat.com>; from dwmw2@infradead.org on Tue, Nov 07, 2000 at 02:41:42PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 02:41:42PM +0000, David Woodhouse wrote:
> get_module_symbol() does this for you without having to use such a hook
> 
> /me runs

So I guess you know already, that it died in 2.4.0-test11-pre1
and you are suggesting dead code? ;-)

Regards

Ingo Oeser
-- 
To the systems programmer, users and applications
serve only to provide a test load.
<esc>:x
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
