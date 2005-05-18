Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262206AbVEROBZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262206AbVEROBZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 10:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262223AbVEROA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 10:00:26 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:23304 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S262203AbVERNub
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 09:50:31 -0400
To: ross@jose.lug.udel.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: software mixing in alsa
References: <20050517095613.GA9947@kestrel>
	<200505171208.04052.jan@spitalnik.net> <20050517141307.GA7759@kestrel>
	<1116354762.31830.12.camel@mindpipe>
	<20050517192412.GA19431@kestrel.twibright.com>
	<200505172027.j4HKRjTV029545@turing-police.cc.vt.edu>
	<20050518063014.GA7053@jose.lug.udel.edu>
From: Nix <nix@esperi.org.uk>
X-Emacs: because you deserve a brk today.
Date: Wed, 18 May 2005 14:50:24 +0100
In-Reply-To: <20050518063014.GA7053@jose.lug.udel.edu> (ross@lug.udel.edu's
 message of "18 May 2005 07:32:44 +0100")
Message-ID: <87acms63tr.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 18 May 2005, ross@lug.udel.edu uttered the following:
> I use esd for all "consumer" level audio apps, and jackd for all
> professional audio apps.  This is by far the simplest way to manage
> audio

In my experience, polypaudio replaces esd with something both simpler
and more powerful. (Oh, and without esd's *horrible* stutter,
interruption, mis-authentication, and code cleanliness problems.)

(For the professional stuff there is no replacement for JACK, I agree.)

-- 
`End users are just test loads for verifying that the system works, kind of
 like resistors in an electrical circuit.' - Kaz Kylheku in c.o.l.d.s
