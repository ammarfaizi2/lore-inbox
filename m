Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267438AbUH3GdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267438AbUH3GdG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 02:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267461AbUH3GdF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 02:33:05 -0400
Received: from nysv.org ([213.157.66.145]:24778 "EHLO nysv.org")
	by vger.kernel.org with ESMTP id S267438AbUH3GdC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 02:33:02 -0400
Date: Mon, 30 Aug 2004 09:31:16 +0300
To: Hubert Chan <hubert@uhoreg.ca>
Cc: reiserfs-list@namesys.com, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: silent semantic changes with reiser4
Message-ID: <20040830063116.GF26192@nysv.org>
References: <Pine.LNX.4.44.0408272158560.10272-100000@chimarrao.boston.redhat.com> <Pine.LNX.4.58.0408271902410.14196@ppc970.osdl.org> <20040828170515.GB24868@hh.idb.hist.no> <Pine.LNX.4.58.0408281038510.2295@ppc970.osdl.org> <4131074D.7050209@namesys.com> <Pine.LNX.4.58.0408282159510.2295@ppc970.osdl.org> <4131A3B2.30203@namesys.com> <20040829104413.GE871@zip.com.au> <87fz65wt82.fsf@uhoreg.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fz65wt82.fsf@uhoreg.ca>
User-Agent: Mutt/1.5.6i
From: mjt@nysv.org (Markus  =?ISO-8859-1?Q?=20T=F6rnqvist?=)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 29, 2004 at 05:05:17PM -0400, Hubert Chan wrote:
>Reiserfs list, and I don't think there was much consensus that came out

It's like Gentoo users and patch sets ;)

>of it.  Currently for Reiser4, AFAIK, the "metas" name is a compile-time
>option that you can change by changing a #define, if you're worried
>about name clashes.

http://mjt.nysv.org/reiser/reiser4.metas.patch

-- 
mjt

