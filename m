Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314451AbSFTOSt>; Thu, 20 Jun 2002 10:18:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314458AbSFTOSs>; Thu, 20 Jun 2002 10:18:48 -0400
Received: from harrier.mail.pas.earthlink.net ([207.217.120.12]:64977 "EHLO
	harrier.mail.pas.earthlink.net") by vger.kernel.org with ESMTP
	id <S314451AbSFTOSs>; Thu, 20 Jun 2002 10:18:48 -0400
Date: Thu, 20 Jun 2002 10:20:41 -0400
To: davej@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] (1/2) reverse mapping VM for 2.5.23 (rmap-13b)
Message-ID: <20020620142041.GA32282@rushmore>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
From: rwhron@earthlink.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> "Use SCSI drivers with broken error handling [DANGEROUS]" in the SCSI
> submenu will give same behaviour as that driver does in Linus' tree.
> Ie, it will compile, but possibly not have any working error handling.
> It should be ok for benchmarking though..

I will try that with the latest -dj after the current run (2.4.19-pre10 + 
Jen's blockhighmem + Andy Kleen's select/poll) completes. 

-- 
Randy Hron
http://home.earthlink.net/~rwhron/

