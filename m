Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131344AbRC3KeJ>; Fri, 30 Mar 2001 05:34:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131296AbRC3Kd7>; Fri, 30 Mar 2001 05:33:59 -0500
Received: from danielle.hinet.hr ([195.29.254.157]:30222 "EHLO
	danielle.hinet.hr") by vger.kernel.org with ESMTP
	id <S131344AbRC3Kdq>; Fri, 30 Mar 2001 05:33:46 -0500
Date: Fri, 30 Mar 2001 12:33:09 +0200
From: Mario Mikocevic <mozgy@hinet.hr>
To: "Butter, Frank" <Frank.Butter@otto.de>
Cc: "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: Re: 2.4 on COMPQ Proliant
Message-ID: <20010330123309.A1248@danielle.hinet.hr>
In-Reply-To: <4B6025B1ABF9D211B5860008C75D57CC0271B9DE@NTOVMAIL04>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
In-Reply-To: <4B6025B1ABF9D211B5860008C75D57CC0271B9DE@NTOVMAIL04>; from Frank.Butter@otto.de on Thu, Mar 29, 2001 at 05:11:16PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 29, 2001 at 05:11:16PM +0200, Butter, Frank wrote:
> Has anyone experiences with 2.4.x on recent Compaq Proliant Servers (e.g.
> ML570)?
> 
> I've installed RedHat7 and it worked fine out of the box.
> Except that the SMP-enabled kernel stated there was no SMP-board detected
> ;-/
> For some reasons (Fibrechannel drivers and so on) I've compiled
> 2.4.2 and installed it. Although I've compiled the support in, the
> NCR-SCSI-chip was not found and therefore no root-partition. It is a model
> supported by 53c8xx - detected by the original RedHat-kernel.  
> 
> For testing I compiled a kernel with all (!) scsi-low-level-drivers -
> with the same result. The SMP-board also was NOT detected by 2.4.2.
> 
> Any hint?

Update BIOS !

-- 
Mario Mikoèeviæ (Mozgy)
My favourite FUBAR ...
