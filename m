Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264741AbTFQNzV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 09:55:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264743AbTFQNzU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 09:55:20 -0400
Received: from madrid10.amenworld.com ([217.174.194.138]:21513 "EHLO
	madrid10.amenworld.com") by vger.kernel.org with ESMTP
	id S264741AbTFQNzM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 09:55:12 -0400
Date: Tue, 17 Jun 2003 16:14:52 +0200
From: DervishD <raul@pleyades.net>
To: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
Cc: Maciej =?iso-8859-1?Q?G=F3rnicki?= <gutko@poczta.onet.pl>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21 working OK compiled with GCC 3.2.2
Message-ID: <20030617141452.GB4950@DervishD>
References: <20030617111718.GD64@DervishD> <000b01c334c4$f2396d30$41010101@toshiba> <1055858387.588.1.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1055858387.588.1.camel@teapot.felipe-alfaro.com>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Felipe :)

 * Felipe Alfaro Solana <felipe_alfaro@linuxmail.org> dixit:
> On Tue, 2003-06-17 at 13:38, Maciej Górnicki wrote:
> > I had even no problems compiling 2.4.21-ac1 with gcc3.3 :)
> gcc 3.2.2 has some nasty bugs... At least, I have been smashing my head
> against a wall for a long time, until I discovered that all my OOPses
> and crashes with the ymfpci driver were caused by gcc 3.2.2.

    Darn... I think I should update then, although I'm not sure I'm
affected by the O_DIRECT miscompiling bug :??

    Thanks for the warning, Felipe :)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
