Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265600AbUBJE0u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 23:26:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265603AbUBJE0u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 23:26:50 -0500
Received: from mtaw4.prodigy.net ([64.164.98.52]:6863 "EHLO mtaw4.prodigy.net")
	by vger.kernel.org with ESMTP id S265600AbUBJE0t (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 23:26:49 -0500
Date: Mon, 9 Feb 2004 20:26:24 -0800
From: Mike Fedyk <mfedyk@matchmail.com>
To: Stefan Voelkel <Stefan.Voelkel@millenux.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, Linus Torvalds <torvalds@osdl.org>,
       Tim Hockin <thockin@sun.com>,
       Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
       akpm@osld.org.sun.com, Daniel Riek <riek@redhat.com>
Subject: Re: PATCH - NGROUPS 2.6.2rc2 + fixups
Message-ID: <20040210042624.GE18674@srv-lnx2600.matchmail.com>
Mail-Followup-To: Stefan Voelkel <Stefan.Voelkel@millenux.com>,
	Rusty Russell <rusty@rustcorp.com.au>,
	Linus Torvalds <torvalds@osdl.org>, Tim Hockin <thockin@sun.com>,
	Linux Kernel mailing list <linux-kernel@vger.kernel.org>,
	akpm@osld.org.sun.com, Daniel Riek <riek@redhat.com>
References: <20040130021802.AA5BC2C0BF@lists.samba.org> <1076326687.15404.72.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1076326687.15404.72.camel@localhost>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 09, 2004 at 12:38:07PM +0100, Stefan Voelkel wrote:
> Hi,
> 
> anything new about this patch?
> 
> I'd like to see this problem solved too, also because of a samba, mad
> integration with the need of > 256 groups per user.

Has anyone else seen a limit of 16 groups with nss-ldap?
