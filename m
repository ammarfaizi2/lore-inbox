Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267567AbUHEGap@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267567AbUHEGap (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 02:30:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267568AbUHEGap
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 02:30:45 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:17800
	"EHLO acheron.informatik.uni-muenchen.de") by vger.kernel.org
	with ESMTP id S267567AbUHEGan (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 02:30:43 -0400
Message-ID: <4111D412.6020107@bio.ifi.lmu.de>
Date: Thu, 05 Aug 2004 08:30:42 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Neil Brown <neilb@cse.unsw.edu.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: NFS-mounted, read-only /dev unusable in 2.6
References: <410F481C.9090408@bio.ifi.lmu.de>	<64bf.410f9d6f.62af@altium.nl>	<ceouv0$7s8$2@news.cistron.nl>	<41108380.6080809@bio.ifi.lmu.de>	<20040804064716.GA31600@traveler.cistron.net>	<16656.35530.819884.579436@cse.unsw.edu.au>	<4110BBEF.1040709@bio.ifi.lmu.de> <16656.49742.597235.511861@cse.unsw.edu.au>
In-Reply-To: <16656.49742.597235.511861@cse.unsw.edu.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

Neil Brown wrote:

> .... It looks like it was *so* recent that I haven't actually
> submitted the patch yet :-(
> 
> I think someone reported it, I sent them a patch, and never got a
> confirmation that it worked (or missed it if I did) so the patch
> didn't progres..
> 
> Try the following.

it works :-)) Especially, I got my initial console back for the diskless
clients and can again see all the debugging output from my init script,
and that really really helps.

Thanks a lot for that patch!

cu,
Frank

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

