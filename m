Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266940AbTADOYK>; Sat, 4 Jan 2003 09:24:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266941AbTADOYK>; Sat, 4 Jan 2003 09:24:10 -0500
Received: from pasmtp.tele.dk ([193.162.159.95]:64264 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id <S266940AbTADOYJ>;
	Sat, 4 Jan 2003 09:24:09 -0500
Date: Sat, 4 Jan 2003 15:32:40 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: junkio@cox.net
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: [RFC] Documentation/modules.txt
Message-ID: <20030104143240.GA2427@mars.ravnborg.org>
Mail-Followup-To: junkio@cox.net, Sam Ravnborg <sam@ravnborg.org>,
	linux-kernel@vger.kernel.org
References: <fa.gg57a2v.1j56o1v@ifi.uio.no> <7v1y3typ9v.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7v1y3typ9v.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 04, 2003 at 06:15:40AM -0800, junkio@cox.net wrote:
> diff -u 2.4.20/scripts/Configure 2.4.20/scripts/Configure
> --- 2.4.20/scripts/Configure	2001-07-02 13:56:40.000000000 -0700
> +++ 2.4.20/scripts/Configure	2003-01-04 06:12:18.000000000 -0800

I can see you diffed 2.4.20.
make dep is mandatory in the 2.4 kernel!

The configure script is no longer present in the 2.5 kernel.

	Sam
