Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965160AbVITWOG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965160AbVITWOG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Sep 2005 18:14:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965165AbVITWOF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Sep 2005 18:14:05 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:25361 "EHLO
	mail.esperi.org.uk") by vger.kernel.org with ESMTP id S965060AbVITWOB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Sep 2005 18:14:01 -0400
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/7] Add dm-snapshot tutorial in Documentation
References: <20050920184513.14557.8152.stgit@zion.home.lan>
From: Nix <nix@esperi.org.uk>
X-Emacs: don't cry -- it won't help.
Date: Tue, 20 Sep 2005 23:13:50 +0100
In-Reply-To: <20050920184513.14557.8152.stgit@zion.home.lan> (Paolo
 Giarrusso's message of "20 Sep 2005 19:51:22 +0100")
Message-ID: <874q8f5qw1.fsf@amaterasu.srvr.nix>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Sep 2005, Paolo Giarrusso docced:
> +When you create a LVM* snapshot of a volume, four dm devices are used:
[...]
> +* I've verified this with LVM 2.01.09, however I assume this is the LVM2 way
> +  of doing this.

Yes; LVM1 doesn't use device-mapper at all, so these docs don't apply to
it.

-- 
`One cannot, after all, be expected to read every single word
 of a book whose author one wishes to insult.' --- Richard Dawkins
