Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312136AbSCZTqB>; Tue, 26 Mar 2002 14:46:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312451AbSCZTpv>; Tue, 26 Mar 2002 14:45:51 -0500
Received: from zeus.kernel.org ([204.152.189.113]:12422 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S312136AbSCZTpo>;
	Tue, 26 Mar 2002 14:45:44 -0500
Date: Tue, 26 Mar 2002 20:38:27 +0100
From: Ragnar Hojland Espinosa <ragnar@jazzfree.com>
To: Vinolin <vinolin@nodeinfotech.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: struct fib_table
Message-ID: <20020326203827.D2539@ragnar-hojland.com>
In-Reply-To: <02032514471601.00954@Vinolin>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Organization: Mediocrity Naysayers Ltd
X-Homepage: http://lightside.eresmas.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 25, 2002 at 02:47:16PM +0530, Vinolin wrote:
> Hello all ,
>
> In linux routing, two tables are maintained ( main_table and local_table ).
> Can somebody explains what is the need for these two tables ?
> Please give a detailed explanation.

The need for the tables is in userspace.  Have a look here:

        http://www.compendium.com.ar/policy-routing.txt
	
and related tarballs mentioned in CONFIG_IP_MULTIPLE_TABLES in
Configure.help I think.

-- 
____/|  Ragnar Højland      Freedom - Linux - OpenGL |    Brainbench MVP
\ o.O|  PGP94C4B2F0D27DE025BE2302C104B78C56 B72F0822 | for Unix Programming
 =(_)=  "Thou shalt not follow the NULL pointer for  | (www.brainbench.com)
   U     chaos and madness await thee at its end."      [15 pend. Mar 10]
