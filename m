Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265227AbTLRPgG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 10:36:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265226AbTLRPgF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 10:36:05 -0500
Received: from main.gmane.org ([80.91.224.249]:38797 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S265229AbTLRPfz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 10:35:55 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@kth.se (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: PROBLEM: Bug-Report, Linux 2.6.0
Date: Thu, 18 Dec 2003 16:35:51 +0100
Message-ID: <yw1x8yladtpk.fsf@kth.se>
References: <3FE1C843.70608@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Rational FORTRAN, linux)
Cancel-Lock: sha1:zsti9q7QBYckhQ3p9E/E5p/JYZA=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christian Schmidt <GMSmith@gmx.net> writes:

> When starting up the new Kernel 2.6.0 in vesa-fb mode, german umlauts
> (and possibly other special characters) aren't displayed
> properly. Problem has been there since test9 or even earlier versions.

It's a font thing.  I don't know why the fb fonts use a different
character map than the standard vga font.

> When trying to access a RIO 500 mp3-player through the tools from
> rio500.sf.net, the rio freezes and needs to be unplugged and the
> battery needs to be removed to make it revert to its normal
> state. It's not possible to up- or download files on or from
> it. Problem has been there since test9 or even earlier aswell.

That sounds more like a bug in the mp3 player.

-- 
Måns Rullgård
mru@kth.se

