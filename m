Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262239AbREZXDH>; Sat, 26 May 2001 19:03:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262656AbREZXBn>; Sat, 26 May 2001 19:01:43 -0400
Received: from zeus.kernel.org ([209.10.41.242]:20647 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S262584AbREZXA1>;
	Sat, 26 May 2001 19:00:27 -0400
Message-ID: <3B0FD318.1E2379C7@Synopsys.COM>
Date: Sat, 26 May 2001 18:00:24 +0200
From: Harald Dunkel <harri@Synopsys.COM>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.4.5: 'mount /cdrom' doesn't work
In-Reply-To: <3B0FBD25.8956C693@Synopsys.COM> <20010526163232.A553@suse.de> <3B0FC6A1.857DBF4@Synopsys.COM> <20010526170902.E553@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
> 
> The only changes that could matter would be SCSI driver changes. You
> wouldn't happen to use the new aic7xxx driver?
> 
I had the same problem with the IDE CD writer (using SCSI emulation).


Regards

Harri
