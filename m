Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266293AbUHROIa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266293AbUHROIa (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 10:08:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266303AbUHROIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 10:08:30 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:55170
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S266293AbUHROIY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 10:08:24 -0400
Message-ID: <412362D5.9020309@bio.ifi.lmu.de>
Date: Wed, 18 Aug 2004 16:08:21 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
Cc: Andreas Messer <andreas.messer@gmx.de>, linux-kernel@vger.kernel.org,
       Ballarin.Marc@gmx.de, christer@weinigel.se
Subject: Re: [PATCH] 2.6.8.1 Mis-detect CRDW as CDROM
References: <411FD919.9030702@comcast.net> <20040816231211.76360eaa.Ballarin.Marc@gmx.de> <4121A689.8030708@bio.ifi.lmu.de> <200408171311.06222.satura@proton> <20040817155927.GA19546@proton-satura-home> <41234500.5080500@bio.ifi.lmu.de>
In-Reply-To: <41234500.5080500@bio.ifi.lmu.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

sorry, the problem was just caused by an empty line in front of a closing
bracket... This somehow removed some (although not all) of the safe_for_read
commands from the list.

I thought I had missed some piece of information here, but it were just my
bad editing skills :-)

Sorry for bothering! Everything works fine now that I added some commands.

Thanks for all your help!
cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049
* Rekursion kann man erst verstehen, wenn man Rekursion verstanden hat. *
