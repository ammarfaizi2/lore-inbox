Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262492AbVAKHuX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262492AbVAKHuX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jan 2005 02:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262563AbVAKHuU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jan 2005 02:50:20 -0500
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:23266
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S262505AbVAKHtQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jan 2005 02:49:16 -0500
Message-ID: <41E384FA.80507@bio.ifi.lmu.de>
Date: Tue, 11 Jan 2005 08:49:14 +0100
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041207)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: uselib()  & 2.6.X?
References: <Pine.LNX.4.58LT.0501071648160.30645@oceanic.wsisiz.edu.pl>	 <20050107170712.GK29176@logos.cnet>	 <1105136446.7628.11.camel@localhost.localdomain>	 <Pine.LNX.4.58.0501071609540.2386@ppc970.osdl.org>	 <20050107221255.GA8749@logos.cnet>	 <Pine.LNX.4.58.0501081042040.2386@ppc970.osdl.org>	 <20050108182841.GD2701@logos.cnet>	 <Pine.LNX.4.58.0501081734400.2339@ppc970.osdl.org>	 <20050109110630.GA9144@logos.cnet>  <41E23E26.50403@bio.ifi.lmu.de> <1105380726.12004.79.camel@localhost.localdomain>
In-Reply-To: <1105380726.12004.79.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Alan, thanks Marcelo!

Alan Cox wrote

> If you want a patch right now grab the -ac patches (they also fix a pile
> of other less holes found including the grsecurity ones). The -ac
> version of the fix should be complete but it won't be the final one in
> the master tree (I get to nail holes shut Linus has to do the right
> engineering for the long term 8))

So I will use -ac until 2.6.11 is out :-)

Thanks!


-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
