Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRFTQBv>; Wed, 20 Jun 2001 12:01:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262550AbRFTQBl>; Wed, 20 Jun 2001 12:01:41 -0400
Received: from 22dyn160.com21.casema.net ([213.17.92.160]:65295 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S262355AbRFTQB2>;
	Wed, 20 Jun 2001 12:01:28 -0400
Date: Wed, 20 Jun 2001 17:59:37 +0200
From: bert hubert <ahu@ds9a.nl>
To: Alexander Viro <viro@math.psu.edu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Threads are processes that share more
Message-ID: <20010620175937.A8159@home.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	Alexander Viro <viro@math.psu.edu>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <d37ky7ch0w.fsf@lxplus015.cern.ch> <Pine.GSO.4.21.0106201127350.24658-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.GSO.4.21.0106201127350.24658-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Wed, Jun 20, 2001 at 11:33:55AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rounding up, it may be worth repeating what I think Alan said some months
ago:

                    Threads are processes that share more

And if we just keep bearing that out to everybody a lot of the myths will go
away. I would suggest that the pthreads manpages get this attitude.

Regards,

bert hubert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
