Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281138AbRKYV5u>; Sun, 25 Nov 2001 16:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281129AbRKYV5l>; Sun, 25 Nov 2001 16:57:41 -0500
Received: from grip.panax.com ([63.163.40.2]:40968 "EHLO panax.com")
	by vger.kernel.org with ESMTP id <S281128AbRKYV5U>;
	Sun, 25 Nov 2001 16:57:20 -0500
Date: Sun, 25 Nov 2001 16:55:06 -0500
From: Patrick McFarland <unknown@panax.com>
To: "Mohammad A. Haque" <mhaque@haque.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.16-pre1
Message-ID: <20011125165506.F238@localhost>
Mail-Followup-To: "Mohammad A. Haque" <mhaque@haque.net>,
	linux-kernel@vger.kernel.org
In-Reply-To: <20011124214114.E241@localhost> <46FF80FA-E151-11D5-A24C-00306569F1C6@haque.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <46FF80FA-E151-11D5-A24C-00306569F1C6@haque.net>
User-Agent: Mutt/1.3.23i
X-Operating-System: Linux 2.4.14 i686
X-Distributed: Join the Effort!  http://www.distributed.net/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Yeah, but there have been one or two security problems in recent 2.4 kernels. Like the symlink attack one.

On 24-Nov-2001, Mohammad A. Haque wrote:
> On Saturday, November 24, 2001, at 09:41 , Patrick McFarland wrote:
> 
> >Okay, so it was 14 that had the file loopback bug, and 12 that had the 
> >ieee bug.Those bugs shouldnt have been in there in the first place! 
> >Those are very major potentially show stopping bugs. What If I get up 
> >one day, and I cant print? Or build isos? That sounds minor to you, but 
> >thats a big thing if say, the linux box is a network print server, or, 
> >its the workstation for the guy in the company who builds the iso. And, 
> >no, "use the previous kernel" isnt a good excuse. Because what if you 
> >get hit with bugs back to back? You'll have to go back to some kernel 
> >way way back. Like 2.4.2. The Kernel needs Quality Assurance.
> 
> Yes, this is a QA problem. But also .. if you're a smart net/system 
> admin, you don't go out installing a just released kernel without 
> letting others bang on it or run it on some test servers. Where I work, 
> I insist the admins wait at least 1-2 weeks before going to the latest 
> release unless there's some huge security fix.
> 
> --
> 
> =====================================================================
> Mohammad A. Haque                              http://www.haque.net/
>                                                mhaque@haque.net
> 
>   "Alcohol and calculus don't mix.             Developer/Project Lead
>    Don't drink and derive." --Unknown          http://www.themes.org/
>                                                batmanppc@themes.org
> =====================================================================
> 

-- 
Patrick "Diablo-D3" McFarland || unknown@panax.com
