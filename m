Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030367AbVLGVqF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030367AbVLGVqF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Dec 2005 16:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030369AbVLGVqF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Dec 2005 16:46:05 -0500
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:4874 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S1030367AbVLGVqE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Dec 2005 16:46:04 -0500
To: Rob Landley <rob@landley.net>
Cc: Chris Wright <chrisw@osdl.org>, Adrian Bunk <bunk@stusta.de>,
       Greg KH <greg@kroah.com>, Jesper Juhl <jesper.juhl@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
References: <20051203135608.GJ31395@stusta.de>
	<20051203225105.GO31395@stusta.de>
	<20051203233511.GL7991@shell0.pdx.osdl.net>
	<200512051837.24187.rob@landley.net>
From: Nix <nix@esperi.org.uk>
X-Emacs: you'll understand when you're older, dear.
Date: Wed, 07 Dec 2005 21:38:12 +0000
In-Reply-To: <200512051837.24187.rob@landley.net> (Rob Landley's message of
 "6 Dec 2005 03:19:31 -0000")
Message-ID: <87oe3svb97.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 6 Dec 2005, Rob Landley moaned:
> On Saturday 03 December 2005 17:35, Chris Wright wrote:
>> relevant.  About the only thing I think is helpful in this case is perhaps
>> one extra -stable cycle on the last branch when newest branch is released
>> (basically flush the queue).  That much I'm willing to do in -stable.
> 
> Yay rah cool!

Seconded (thirded?), this is a very good idea (and as it's just a queue
flush is probably quite easy to do).

That way those of us who are paranoid can upgrade our experimental boxes
immediately, apply the latest -stable to the non-experimental boxes, and
then cautiously upgrade those boxes when the experimental ones seem to
be working OK. Currently whenever there's a non-stable kernel rev I'm
filled with trepidation: do I upgrade the stable boxes and risk
instability, or leave them as they are and risk insecurity?

-- 
`Y'know, London's nice at this time of year. If you like your cities
 freezing cold and full of surly gits.' --- David Damerell

