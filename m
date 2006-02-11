Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932270AbWBKNuM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932270AbWBKNuM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Feb 2006 08:50:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932284AbWBKNuM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Feb 2006 08:50:12 -0500
Received: from soohrt.org ([85.131.246.150]:33693 "EHLO quickstop.soohrt.org")
	by vger.kernel.org with ESMTP id S932270AbWBKNuK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Feb 2006 08:50:10 -0500
Date: Sat, 11 Feb 2006 14:50:03 +0100
From: Horst Schirmeier <horst@schirmeier.com>
To: linux-kernel@vger.kernel.org
Cc: Hans Reiser <reiser@namesys.com>, Vitaly Fertman <vitaly@namesys.com>,
       Andrew Morton <akpm@osdl.org>, Greg Kroah-Hartman <gregkh@suse.de>
Subject: Re: [BUG] reiserfs/super.c commit breaks boot process in stable and HEAD
Message-ID: <20060211135003.GV22994@quickstop.soohrt.org>
Mail-Followup-To: linux-kernel@vger.kernel.org,
	Hans Reiser <reiser@namesys.com>,
	Vitaly Fertman <vitaly@namesys.com>, Andrew Morton <akpm@osdl.org>,
	Greg Kroah-Hartman <gregkh@suse.de>
References: <20060207160819.GR22994@quickstop.soohrt.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060207160819.GR22994@quickstop.soohrt.org>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2006, Horst Schirmeier wrote:
> Hi,
> 
> I'm observing an instant reboot while booting current stable or HEAD
> kernels since a recent ReiserFS commit. Details and temporary fix
> below.
> [...]

Just for the records: I've opened a bug report on bugme.osdl.org.
http://bugme.osdl.org/show_bug.cgi?id=6054

Kind regards,
 Horst Schirmeier

-- 
PGP-Key 0xD40E0E7A
