Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288428AbSADAiL>; Thu, 3 Jan 2002 19:38:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288426AbSADAiB>; Thu, 3 Jan 2002 19:38:01 -0500
Received: from odin.allegientsystems.com ([208.251.178.227]:1945 "EHLO
	lasn-001.allegientsystems.com") by vger.kernel.org with ESMTP
	id <S288428AbSADAhn>; Thu, 3 Jan 2002 19:37:43 -0500
Message-ID: <3C34F937.8090700@allegientsystems.com>
Date: Thu, 03 Jan 2002 19:37:11 -0500
From: Nathan Bryant <nbryant@allegientsystems.com>
Organization: Allegient Systems
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011226
X-Accept-Language: en-us
MIME-Version: 1.0
To: Nick Papadonis <nick@coelacanth.com>
CC: Martin Dalecki <dalecki@evision-ventures.com>,
        Thomas Gschwind <tom@infosys.tuwien.ac.at>,
        linux-kernel@vger.kernel.org, Doug Ledford <dledford@redhat.com>
Subject: Re: [Fwd: i810_audio]
In-Reply-To: <3C3382CA.3000503@allegientsystems.com>	<3C345493.5040800@evision-ventures.com>	<20020103154718.C32419@infosys.tuwien.ac.at>	<3C347A12.3070404@evision-ventures.com>	<3C34B35A.7000309@allegientsystems.com> <m3ell76p4h.fsf@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Papadonis wrote:

>I tried the 0.13 driver yesterday.  It appears to work fine, but when
>I insert my Orinoco WaveLan card they system locks up.  I reverted to
>the i810 audio driver included in kernel v2.4.16 and this problem
>isn't encountered.
>
>Is there a conflict with the orinoco and orinoco_cs drivers from
>kernel v2.4.16?
>
>- Nick
>
Damned if I know! Is your system perhaps assigning a shared interrupt 
between the orinoco and audio?

