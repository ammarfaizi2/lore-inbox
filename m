Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266854AbUBGEPT (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Feb 2004 23:15:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266856AbUBGEPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Feb 2004 23:15:19 -0500
Received: from ms-smtp-01.rdc-kc.rr.com ([24.94.166.115]:2444 "EHLO
	ms-smtp-01.rdc-kc.rr.com") by vger.kernel.org with ESMTP
	id S266854AbUBGEPP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Feb 2004 23:15:15 -0500
Date: Fri, 6 Feb 2004 22:15:10 -0600
From: Greg Norris <haphazard@kc.rr.com>
To: linux-kernel <linux-kernel@vger.kernel.org>,
       linux-usb-users@lists.sourceforge.net,
       linux-usb-devel@lists.sourceforge.net
Subject: Re: usb mouse/keyboard problems under 2.6.2
Message-ID: <20040207041510.GA3724@yggdrasil.localdomain>
Mail-Followup-To: linux-kernel <linux-kernel@vger.kernel.org>,
	linux-usb-users@lists.sourceforge.net,
	linux-usb-devel@lists.sourceforge.net
References: <20040204174748.GA27554@yggdrasil.localdomain> <20040205142155.GA606@ucw.cz> <20040205160226.GA13471@yggdrasil.localdomain> <20040205230304.GA2195@yggdrasil.localdomain> <20040206011531.GA2084@yggdrasil.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040206011531.GA2084@yggdrasil.localdomain>
X-Operating-System: Linux yggdrasil 2.6.2-rc1bk3 #1 SMP Fri Feb 6 16:53:57 CST 2004 i686 GNU/Linux
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 05, 2004 at 07:15:31PM -0600, Greg Norris wrote:
> The problem appears to have been introduced in 2.6.2-rc2.  Can anyone
> tell me how to find the individual patches which were added between
> -rc1 and -rc2?  I can diff the trees easily enough, of course, but it
> would be much easier if I had a collection of discrete patches to work
> with.

More specifically, 2.6.2-rc1-bk3 appears to be the earliest affected
version.  I haven't had a chance to try backing out individual patches,
so I don't yet know which particular update causes my problem.
