Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287953AbSAMTB5>; Sun, 13 Jan 2002 14:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288019AbSAMTBr>; Sun, 13 Jan 2002 14:01:47 -0500
Received: from smtp-out-7.wanadoo.fr ([193.252.19.26]:14818 "EHLO
	mel-rto7.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S287953AbSAMTBi>; Sun, 13 Jan 2002 14:01:38 -0500
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <linux-kernel@vger.kernel.org>,
        =?US-ASCII?Q?Jacek=20Pop=3Fawski?= <jpopl@interia.pl>
Subject: Re: radeonfb
Date: Sun, 13 Jan 2002 20:01:11 +0100
Message-Id: <20020113190111.7905@smtp.wanadoo.fr>
In-Reply-To: <20020113170228.A1529@localhost.localdomain>
In-Reply-To: <20020113170228.A1529@localhost.localdomain>
X-Mailer: CTM PowerMail 3.1.1 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>I compiled 2.4.18-pre3 with radeonfb patch. Console works without
>problems, but
>every time I start fbi or fbtv:
>- colors are bad (depth problem)
>- when I quit application - monitor turns off (probably bad mode setting, but
>  why mode is changed?), it turns on when I switch virtual console (then
I can
>  go back)
>When I use "fbset 800x600-100" I have 24 bit depth, but I can't set
>800x600-24@100 as lilo parameter. Only 800x600-16@100 works OK. 
>Is there any radeonfb documentation or project page available?

Well, there's a radeonfb maintainer, you could email him.

Ben.


