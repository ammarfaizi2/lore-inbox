Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280637AbRKFW2s>; Tue, 6 Nov 2001 17:28:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280630AbRKFW2k>; Tue, 6 Nov 2001 17:28:40 -0500
Received: from codepoet.org ([166.70.14.212]:63530 "EHLO winder.codepoet.org")
	by vger.kernel.org with ESMTP id <S280625AbRKFW20>;
	Tue, 6 Nov 2001 17:28:26 -0500
Date: Tue, 6 Nov 2001 15:28:26 -0700
From: Erik Andersen <andersen@codepoet.org>
To: Rik van Riel <riel@conectiva.com.br>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROPOSAL: /proc standards (was dot-proc interface [was: /proc
Message-ID: <20011106152826.C31923@codepoet.org>
Reply-To: andersen@codepoet.org
Mail-Followup-To: Erik Andersen <andersen@codepoet.org>,
	Rik van Riel <riel@conectiva.com.br>, linux-kernel@vger.kernel.org
In-Reply-To: <slrn9ugh1g.dld.spamtrap@dexter.hensema.xs4all.nl> <Pine.LNX.4.33L.0111061921240.27028-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33L.0111061921240.27028-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.22i
X-Operating-System: 2.4.12-ac3-rmk2, Rebel NetWinder (Intel StrongARM-110 rev 3), 185.95 BogoMips
X-No-Junk-Mail: I do not want to get *any* junk mail.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Nov 06, 2001 at 07:24:13PM -0200, Rik van Riel wrote:
> I really fail to see your point, it's trivial to make
> files which are easy to read by humans and also very
> easy to parse by shellscripts.
> 
> PROCESSOR=0
> VENDOR_ID=GenuineIntel
> CPU_FAMILY=6
> MODEL=6
> MODEL_NAME="Celeron (Mendocino)"
> .....
> 
> As you can see, this is easily readable by humans,
> while "parsing" by a shell script would be as follows:
> 
> . /proc/cpuinfo
> 
> After which you could just "echo $PROCESSOR" or
> something like that ...

I think we have a winner!  If we could establish this 
as policy that would be _sweet_!

 -Erik

--
Erik B. Andersen             http://codepoet-consulting.com/
--This message was written using 73% post-consumer electrons--
