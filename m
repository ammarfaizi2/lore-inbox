Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263478AbTHXL5H (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Aug 2003 07:57:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbTHXL5H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Aug 2003 07:57:07 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:38664 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S263478AbTHXL4w (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Aug 2003 07:56:52 -0400
Date: Sun, 24 Aug 2003 13:56:50 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: John Newbie <john_r_newbie@hotmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Night builds.
Message-ID: <20030824115650.GA937@mars.ravnborg.org>
Mail-Followup-To: John Newbie <john_r_newbie@hotmail.com>,
	linux-kernel@vger.kernel.org
References: <Law14-F100MduuJNc3J00001f8f@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Law14-F100MduuJNc3J00001f8f@hotmail.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 24, 2003 at 05:43:38AM +0400, John Newbie wrote:
> Hi guys!
> Is there any night builds farm for Linux project?
> As far as I know many sw companies (even ms) have such. It greatly help to 
> hunt and collect BUGs.
> I think it is very easy to write apropriate scripts (or software) to do 
> regular builds and testing.
> Correct me if I am wrong - most of  the bug-reports are from 
> geeks/sysadmins/developers.
> Why not to use automation provided by computers?
> 
> If my idea is bad (or discussed earlier) just skip it.

John Cherry from OSDL has something like you propose.
It build each night + for each release.
Only releases are followed with extensive documentation (log's).

Go via http://www.osdl.org | Lab Activities | Linux kernel stability
to find it.
There is also links to other similar efforts for other architectures.

	Sam
