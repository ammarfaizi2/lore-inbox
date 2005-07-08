Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262747AbVGHSDM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262747AbVGHSDM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 14:03:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262742AbVGHSDM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 14:03:12 -0400
Received: from levante.wiggy.net ([195.85.225.139]:64701 "EHLO mx1.wiggy.net")
	by vger.kernel.org with ESMTP id S262738AbVGHSDK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 14:03:10 -0400
Date: Fri, 8 Jul 2005 20:03:03 +0200
From: Wichert Akkerman <wichert@wiggy.net>
To: Bryan Henderson <hbryan@us.ibm.com>
Cc: Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
       bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxram@us.ibm.com, mike@waychison.com,
       Miklos Szeredi <miklos@szeredi.hu>,
       Pekka J Enberg <penberg@cs.helsinki.fi>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: share/private/slave a subtree - define vs enum
Message-ID: <20050708180302.GC1165@wiggy.net>
Mail-Followup-To: Bryan Henderson <hbryan@us.ibm.com>,
	Roman Zippel <zippel@linux-m68k.org>, Andrew Morton <akpm@osdl.org>,
	bfields@fieldses.org, linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxram@us.ibm.com,
	mike@waychison.com, Miklos Szeredi <miklos@szeredi.hu>,
	Pekka J Enberg <penberg@cs.helsinki.fi>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>
References: <Pine.LNX.4.61.0507081527040.3743@scrub.home> <OFF7ECFC50.4EDB3D93-ON88257038.0059F048-88257038.005AEAF4@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OFF7ECFC50.4EDB3D93-ON88257038.0059F048-88257038.005AEAF4@us.ibm.com>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Previously Bryan Henderson wrote:
> Two advantages of the enum declaration that haven't been mentioned yet, 
> that help me significantly:

There is another one: with enums the compiler checks types for you.

Wichert.

-- 
Wichert Akkerman <wichert@wiggy.net>    It is simple to make things.
http://www.wiggy.net/                   It is hard to make things simple.
