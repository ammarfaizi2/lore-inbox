Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbVJEXtd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbVJEXtd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:49:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030403AbVJEXtc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:49:32 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:62988 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030425AbVJEXtc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:49:32 -0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: 7eggert@gmx.de, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz> <20051005103612.GQ10538@lkcl.net>
	<871x2zwob2.fsf@amaterasu.srvr.nix> <20051005232844.GV10538@lkcl.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: the prosecution rests its case.
Date: Thu, 06 Oct 2005 00:49:22 +0100
In-Reply-To: <20051005232844.GV10538@lkcl.net> (Luke Kenneth Casson
 Leighton's message of "Thu, 6 Oct 2005 00:28:44 +0100")
Message-ID: <87wtkrv81p.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2005, Luke Kenneth Casson Leighton said:
> On Thu, Oct 06, 2005 at 12:12:49AM +0100, Nix wrote:
>> On 5 Oct 2005, Luke Kenneth Casson Leighton murmured woefully:
>> >  nt 5.0 added hardlinks to ntfs.
>> 
>> Actually they've been present from the start, but only accessible
>> through the POSIX subsystem and (IIRC) the Backup API (?!!)
>  
>  *hack* *cough* *choke* someone call 911. *thump* too late.

I agree, it's barmy. (Cygwin, running under the Win32 subsystem as it
does, manipulates hardlinks via the Backup API.)

I assume the `logic' was that even though hardlinks were only there
for the sake of the mostly-useless POSIX subsystem, you still
might want to back them up...

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
