Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262614AbTHUKe7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Aug 2003 06:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262612AbTHUKe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Aug 2003 06:34:59 -0400
Received: from TYO202.gate.nec.co.jp ([210.143.35.52]:48861 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262614AbTHUKeQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Aug 2003 06:34:16 -0400
To: rob@landley.net
Cc: gkajmowi@tbaytel.net, linux-kernel@vger.kernel.org
Subject: Re: Initramfs confusion
References: <200308161940.52579.gkajmowi@tbaytel.net>
	<200308190414.10317.rob@landley.net>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 21 Aug 2003 19:33:54 +0900
In-Reply-To: <200308190414.10317.rob@landley.net>
Message-ID: <buor83f710t.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rob Landley <rob@landley.net> writes:
> Here's a big cut and paste from a script of mine that does a lot of
> this gorp automatically while creating a bootable CD image.

I've no idea what the original poster really wants, but your script
seems to use initrd, not initramfs (which is much nicer than initrd in
theory).

-Miles
-- 
Occam's razor split hairs so well, I bought the whole argument!
