Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262624AbVAVTCz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262624AbVAVTCz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 14:02:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262636AbVAVTCz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 14:02:55 -0500
Received: from gw.c9x.org ([213.41.131.17]:56585 "HELO
	nerim.mx.42-networks.com") by vger.kernel.org with SMTP
	id S262624AbVAVTCy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 14:02:54 -0500
Date: Sat, 22 Jan 2005 20:02:31 +0100
From: "Frank Denis \(Jedi/Sector One\)" <lkml@pureftpd.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: pre 2.6.11 Possible Memory Leak
Message-ID: <20050122190253.GA24158@c9x.org>
References: <200501221638.j0MGcPce001588@clem.clem-digital.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501221638.j0MGcPce001588@clem.clem-digital.net>
X-Operating-System: OpenBSD - http://www.openbsd.org/
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 22, 2005 at 11:38:25AM -0500, Pete Clements wrote:
> Noticed a couple posts regarding possible memory leak
> in pre 2.6.11. I have also observed the problem, but
> wrote it off to running VMware and the pgtbl changes.

  I can confirm this on web servers and 2.6.11-pre1, 2.6.11-pre1-mm1
and 2.6.11-pre1-mm1-jedi2.

-- 
Frank - my stupid blog: http://00f.net
