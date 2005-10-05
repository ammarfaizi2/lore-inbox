Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030390AbVJEXNA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030390AbVJEXNA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Oct 2005 19:13:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030392AbVJEXNA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Oct 2005 19:13:00 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:54797 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030390AbVJEXNA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Oct 2005 19:13:00 -0400
To: Luke Kenneth Casson Leighton <lkcl@lkcl.net>
Cc: 7eggert@gmx.de, Marc Perkel <marc@perkel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: what's next for the linux kernel?
References: <4TiWy-4HQ-3@gated-at.bofh.it> <4U0XH-3Gp-39@gated-at.bofh.it>
	<E1EMutG-0001Hd-7U@be1.lrz> <20051005103612.GQ10538@lkcl.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: it's not slow --- it's stately.
Date: Thu, 06 Oct 2005 00:12:49 +0100
In-Reply-To: <20051005103612.GQ10538@lkcl.net> (Luke Kenneth Casson
 Leighton's message of "5 Oct 2005 11:36:43 +0100")
Message-ID: <871x2zwob2.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5 Oct 2005, Luke Kenneth Casson Leighton murmured woefully:
> On Wed, Oct 05, 2005 at 12:04:01AM +0200, Bodo Eggert wrote:
>> > You can't even see it in the directory. Netware also
>> > has inherited permissions like Windows and Samba has and this is doing
>> > it right.
>> 
>> You can't do that if you have hardlinks. 
> 
>  nt 5.0 added hardlinks to ntfs.

Actually they've been present from the start, but only accessible
through the POSIX subsystem and (IIRC) the Backup API (?!!)

-- 
`Next: FEMA neglects to take into account the possibility of
fire in Old Balsawood Town (currently in its fifth year of drought
and home of the General Grant Home for Compulsive Arsonists).'
            --- James Nicoll
