Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270178AbRHGKq7>; Tue, 7 Aug 2001 06:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270180AbRHGKqt>; Tue, 7 Aug 2001 06:46:49 -0400
Received: from pD9E16562.dip.t-dialin.net ([217.225.101.98]:58617 "EHLO
	tolot.miese-zwerge.org") by vger.kernel.org with ESMTP
	id <S270178AbRHGKqg>; Tue, 7 Aug 2001 06:46:36 -0400
Date: Tue, 7 Aug 2001 12:46:04 +0200
From: Jochen Striepe <jochen@tolot.escape.de>
To: christophe =?iso-8859-1?Q?barb=E9?= <christophe.barbe@lineo.fr>,
        Thibaut Laurent <thibaut@celestix.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux-2.4.8pre5 does not build
Message-ID: <20010807124604.A29638@tolot.miese-zwerge.org>
In-Reply-To: <20010807114023.A23521@tolot.miese-zwerge.org> <20010807175438.211052d5.thibaut@celestix.com> <20010807114023.A23521@tolot.miese-zwerge.org> <20010807120837.A23823@pc8.lineo.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20010807175438.211052d5.thibaut@celestix.com> <20010807120837.A23823@pc8.lineo.fr>
User-Agent: Mutt/1.3.20i
X-Editor: vim/5.8.9
X-Signature-Color: blue
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

        Hi,

On 07 Aug 2001, christophe barbé <christophe.barbe@lineo.fr> wrote:
> You should read the previous message from Carlo E. Prelz (with the subject
> : "2.4.7ac8: small patch needed") which comes with a solution to your
> problem.

On 07 Aug 2001, Thibaut Laurent <thibaut@celestix.com> wrote:
> 
> It seems to be the same problem as in kernel 2.4.7-ac8.
> Please apply the patch that Carlo E. Prelz sent about one hour ago:

Thanks, that solved it; now it builds fine. 


Greetings from Germany,

Jochen.

-- 
"This software comes with ABSOLUTELY NO WARRANTY. Even if it
erases your hard drive, too bad. Although we did fix that bug
from the last release."
                      --README from a long-ago release of DJGPP 
