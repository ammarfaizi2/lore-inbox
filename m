Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265974AbUBPWuX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Feb 2004 17:50:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265922AbUBPWrd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Feb 2004 17:47:33 -0500
Received: from M881P008.adsl.highway.telekom.at ([62.47.142.8]:1924 "EHLO
	stallburg.dyndns.org") by vger.kernel.org with ESMTP
	id S265946AbUBPWoY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Feb 2004 17:44:24 -0500
Date: Mon, 16 Feb 2004 23:43:43 +0100
From: maximilian attems <janitor@sternwelten.at>
To: Greg KH <greg@kroah.com>
Cc: Stephen Hemminger <shemminger@osdl.org>, Tommi Virtanen <tv@tv.debian.net>,
       Leann Ogasawara <ogasawara@osdl.org>, netdev@oss.sgi.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] don't allow / in class device names
Message-ID: <20040216224343.GF1890@mail.sternwelten.at>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Stephen Hemminger <shemminger@osdl.org>,
	Tommi Virtanen <tv@tv.debian.net>,
	Leann Ogasawara <ogasawara@osdl.org>, netdev@oss.sgi.com,
	linux-kernel@vger.kernel.org
References: <20040213102755.27cf4fcd.shemminger@osdl.org> <20040213203448.GB14048@kroah.com> <20040213124555.00cbf3d7@dell_ss3.pdx.osdl.net> <20040213205936.GE14048@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040213205936.GE14048@kroah.com>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Feb 2004, Greg KH wrote:

> But isn't a '/' character a valid character for a file or directory
> name?  :) 

don't know which posix doc ulrich drepper is quoting,
but it doesn't seem so:
http://marc.theaimsgroup.com/?l=linux-kernel&m=107669877325770&w=2

regards
maks


