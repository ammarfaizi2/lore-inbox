Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264770AbRFTIZA>; Wed, 20 Jun 2001 04:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264853AbRFTIYu>; Wed, 20 Jun 2001 04:24:50 -0400
Received: from 22dyn160.com21.casema.net ([213.17.92.160]:56591 "HELO
	home.ds9a.nl") by vger.kernel.org with SMTP id <S264770AbRFTIYm>;
	Wed, 20 Jun 2001 04:24:42 -0400
Date: Wed, 20 Jun 2001 10:22:52 +0200
From: bert hubert <ahu@ds9a.nl>
To: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: intermittent hangs with threads (clone() bug?/linuxthreads bug?)
Message-ID: <20010620102252.A6553@home.ds9a.nl>
Mail-Followup-To: bert hubert <ahu@ds9a.nl>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
In-Reply-To: <0632CC5F67853B4D96D542BAE8AD008274BA10@merc08.na.sas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <0632CC5F67853B4D96D542BAE8AD008274BA10@merc08.na.sas.com>; from Ed.Connell@sas.com on Tue, Jun 19, 2001 at 05:23:48PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 19, 2001 at 05:23:48PM -0400, Ed Connell wrote:

> If I run, for example, linuxthreads/Examples/ex1 (one thread prints 'a',
>    one prints 'b') it will run fine.  If I run it from a shell script
>    (bash or ksh) with exec ex1
> it almost always hangs.  When I do a "ps" I see the original "ex1" process
> plus another defunct "ex1" process with a higher pid.  This defunct

and if you redirect output to /dev/null?

regards,

bert

-- 
http://www.PowerDNS.com      Versatile DNS Services  
Trilab                       The Technology People   
'SYN! .. SYN|ACK! .. ACK!' - the mating call of the internet
