Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262721AbTHZPbk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Aug 2003 11:31:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262719AbTHZPbk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Aug 2003 11:31:40 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:6045 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S262708AbTHZPbj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Aug 2003 11:31:39 -0400
Subject: Re: authentication / encryption key retention
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Howells <dhowells@redhat.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <11490.1061892774@redhat.com>
References: <Pine.LNX.4.44.0308221044470.20736-100000@home.osdl.org>
	 <11490.1061892774@redhat.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1061911851.20946.47.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 26 Aug 2003 16:30:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-08-26 at 11:12, David Howells wrote:
> If your subset is but a single pre-existing key (where this includes a keyring
> as a specialisation of a key), then yes; but if the filesystem is permitted to
> select multiple keys from different sources, then no.
> 
> I think for the moment, however, we can assume there will be a single key.

How is the key choice different to say selinux roles ?

