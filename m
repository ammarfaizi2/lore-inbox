Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265326AbUBJDDS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 22:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265536AbUBJDDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 22:03:18 -0500
Received: from ms-smtp-03.rdc-kc.rr.com ([24.94.166.129]:60545 "EHLO
	ms-smtp-03.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S265326AbUBJDDP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 22:03:15 -0500
Date: Mon, 9 Feb 2004 21:02:24 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb mouse/keyboard problems under 2.6.2 -- RESOLVED
Message-ID: <20040210030224.GB2117@yggdrasil.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net
References: <20040204174748.GA27554@yggdrasil.localdomain> <20040205142155.GA606@ucw.cz> <20040205160226.GA13471@yggdrasil.localdomain> <20040205230304.GA2195@yggdrasil.localdomain> <20040206011531.GA2084@yggdrasil.localdomain> <20040207041510.GA3724@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040207041510.GA3724@yggdrasil.localdomain>
X-Operating-System: Linux yggdrasil 2.6.2 #1 SMP Mon Feb 9 20:34:02 CST 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 06, 2004 at 10:15:10PM -0600, Greg Norris wrote:
> More specifically, 2.6.2-rc1-bk3 appears to be the earliest affected
> version.  I haven't had a chance to try backing out individual patches,
> so I don't yet know which particular update causes my problem.

Vojtech Pavlik's lost-sync-fix patch seems to have squashed this bug. 
He's my new hero! ;-)
