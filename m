Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161006AbWJYWvb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161006AbWJYWvb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 18:51:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161065AbWJYWvb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 18:51:31 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:64193 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1161006AbWJYWva (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 18:51:30 -0400
Subject: Re: incorrect taint of ndiswrapper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Pavel Roskin <proski@gnu.org>
Cc: David Weinehall <tao@acc.umu.se>, linux-kernel@vger.kernel.org
In-Reply-To: <1161813778.3441.84.camel@dv>
References: <1161807069.3441.33.camel@dv>
	 <1161808227.7615.0.camel@localhost.localdomain>
	 <1161810392.3441.60.camel@dv>  <20061025213355.GG23256@vasa.acc.umu.se>
	 <1161813778.3441.84.camel@dv>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Wed, 25 Oct 2006 23:54:44 +0100
Message-Id: <1161816884.7615.28.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Mer, 2006-10-25 am 18:02 -0400, ysgrifennodd Pavel Roskin:
> And that's what I think is way over the top.  It's akin looking for
> process called "wine" (or detecting it by its behavior) and denying it
> access to some syscalls.

On the contrary there is little likelyhood that wine is a derivative
work, and even if it was the note with the kernel explicitly deals with
that by saying "we don't intend a judge to interpret it that way"


