Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266245AbUHROCG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266245AbUHROCG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 10:02:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266214AbUHROCF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 10:02:05 -0400
Received: from acheron.informatik.uni-muenchen.de ([129.187.214.135]:6274 "EHLO
	acheron.informatik.uni-muenchen.de") by vger.kernel.org with ESMTP
	id S266292AbUHROCC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 10:02:02 -0400
Message-ID: <41236158.6040906@bio.ifi.lmu.de>
Date: Wed, 18 Aug 2004 16:02:00 +0200
From: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040503)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Robert M. Stockmann" <stock@stokkie.net>
Cc: Eric Lammerts <eric@lammerts.org>, Kyle Moffett <mrmacman_g4@mac.com>,
       Patrick McFarland <diablod3@gmail.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
References: <Pine.LNX.4.44.0408181535130.30116-100000@hubble.stokkie.net>
In-Reply-To: <Pine.LNX.4.44.0408181535130.30116-100000@hubble.stokkie.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Robert M. Stockmann wrote:

> Well sorry about that, the machine is not in my possesion anymore. 

Oh please! You are complaining, accusing and flaming SuSE for they
are shipping a cdrecord version that is not working on one single
machine (since you cannot reproduce it yourself on another machine
now to give a dmesg output, it must be very machine-specific...)
after you have forced cdrecord to use some special mode instead
of using the SuSE default.
After Jens told you that this special mode does not work well with
earlier 2.6 kernels and that the default mode SuSE selects when you
don't override it would work without exactly the problem you are
creating by overriding the mode, you still keep complaining. And
when you are asked for further info so that people can help you
the machine is not in you posession anymore.

*cough* *cough*

-- 
Dipl.-Inform. Frank Steiner   Web:  http://www.bio.ifi.lmu.de/~steiner/
Lehrstuhl f. Bioinformatik    Mail: http://www.bio.ifi.lmu.de/~steiner/m/
LMU, Amalienstr. 17           Phone: +49 89 2180-4049
80333 Muenchen, Germany       Fax:   +49 89 2180-99-4049

