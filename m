Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267625AbUHEKad@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267625AbUHEKad (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 06:30:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267626AbUHEKad
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 06:30:33 -0400
Received: from twin.jikos.cz ([213.151.79.26]:61066 "EHLO twin.jikos.cz")
	by vger.kernel.org with ESMTP id S267625AbUHEKa1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 06:30:27 -0400
Date: Thu, 5 Aug 2004 12:30:23 +0200 (CEST)
From: Jirka Kosina <jikos@jikos.cz>
To: Giuliano Pochini <pochini@shiny.it>
cc: linux-kernel@vger.kernel.org
Subject: Re: FW: Linux kernel file offset pointer races
In-Reply-To: <XFMail.20040805104213.pochini@shiny.it>
Message-ID: <Pine.LNX.4.58.0408051228400.2791@twin.jikos.cz>
References: <XFMail.20040805104213.pochini@shiny.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 5 Aug 2004, Giuliano Pochini wrote:

> I don't remember if this issue has already been discussed here:
> -----FW: <Pine.LNX.4.44.0408041220550.26961-100000@isec.pl>-----
> Date: Wed, 4 Aug 2004 12:22:42 +0200 (CEST)
> From: Paul Starzetz <ihaquer@isec.pl>
> To: bugtraq@securityfocus.com, vulnwatch@vulnwatch.org,
>  full-disclosure@lists.netsys.com
> Subject: Linux kernel file offset pointer races

It hasn't been discussed here, but at 
http://linux.bkbits.net:8080/linux-2.4/gnupatch@411064f7uz3rKDb73dEb4vCqbjEIdw 
you can find a patchset fixing (some of) the mentioned problems. This 
patchset is from 2.4.27-rc5

-- 
JiKos.
