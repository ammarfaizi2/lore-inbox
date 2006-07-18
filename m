Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932409AbWGRXK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932409AbWGRXK0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 19:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932413AbWGRXK0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 19:10:26 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:53778 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S932409AbWGRXKZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 19:10:25 -0400
To: Valdis.Kletnieks@vt.edu
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reiser4 Inclusion
References: <44BAFDB7.9050203@calebgray.com>
	<200607171805.k6HI5uvD017963@turing-police.cc.vt.edu>
From: Nix <nix@esperi.org.uk>
X-Emacs: it's like swatting a fly with a supernova.
Date: Wed, 19 Jul 2006 00:10:20 +0100
In-Reply-To: <200607171805.k6HI5uvD017963@turing-police.cc.vt.edu> (Valdis Kletnieks's message of "17 Jul 2006 19:06:27 +0100")
Message-ID: <87ejwibjc3.fsf@hades.wkstn.nix>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 17 Jul 2006, Valdis Kletnieks prattled cheerily:
> On Sun, 16 Jul 2006 20:02:15 PDT, Caleb Gray said:
>> and directory structures. (Both of the filesystems have slowed down at a
>> similar pace for the duration of their lifetime [about 15ms].)
> 
> Unclear why *that* should matter to ICMP either.

I bet his network topology changed, or the extra ARPs turned up later,
assuming he's still talking about ping time and not seek time.

-- 
`We're sysadmins. We deal with the inconceivable so often I can clearly 
 see the need to define levels of inconceivability.' --- Rik Steenwinkel
