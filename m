Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267683AbTAHRUg>; Wed, 8 Jan 2003 12:20:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267692AbTAHRUg>; Wed, 8 Jan 2003 12:20:36 -0500
Received: from pc132.utati.net ([216.143.22.132]:8077 "HELO
	merlin.webofficenow.com") by vger.kernel.org with SMTP
	id <S267683AbTAHRUe> convert rfc822-to-8bit; Wed, 8 Jan 2003 12:20:34 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
To: conman@kolivas.net,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [BENCHMARK] 2.5.53 with contest
Date: Tue, 7 Jan 2003 19:44:18 +0000
User-Agent: KMail/1.4.3
References: <200212261038.04015.conman@kolivas.net>
In-Reply-To: <200212261038.04015.conman@kolivas.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301071944.18098.landley@trommello.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 25 December 2002 23:37, Con Kolivas wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
> Here are some contest results using osdl hardware:
>
> Uniprocessor:
> process_load:
> Kernel [runs]           Time    CPU%    Loads   LCPU%   Ratio
> 2.5.49 [5]              85.2    79      17      20      1.28
> 2.5.50 [5]              84.8    79      17      19      1.27
> 2.5.51 [2]              85.2    79      17      20      1.28
> 2.5.52 [3]              84.4    79      17      19      1.26
> 2.5.53 [7]              86.9    77      18      21      1.30

Could you add a time per load metric?  (I.E. 86.9/21=4.14 seconds.  Yeah, I 
could do the math myself, but that and total time are usually what I'm trying 
to compare when I look at these.  Maybe it's just me...)

Rob

-- 
penguicon.sf.net - A combination Linux Expo and Science Fiction Convention 
with GOHs Terry Pratchett, Eric Raymond, Pete Abrams, Illiad & CmdrTaco.


