Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261845AbTEFUjQ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 16:39:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261849AbTEFUjQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 16:39:16 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:17793
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S261845AbTEFUjO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 16:39:14 -0400
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506185433.GA6023@mail.jlokier.co.uk>
References: <20030506164252.GA5125@mail.jlokier.co.uk>
	 <1052242508.1201.43.camel@dhcp22.swansea.linux.org.uk>
	 <20030506185433.GA6023@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052250792.1983.160.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 20:53:14 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What if this new-fangled other kernel is open source, but BSD license
> instead?  Would that also anger the kernel developers?  (As I suspect
> a closed-source binary kernel would, even if one could get away with it).

Then the combined result would be a GPL'd product. You can do that now.
Add BSD code to GPL and the result comes out GPL.

> Then, you can (a) rewrite everything, using the knowledge you gained
> from reading the various open source drivers, or (b) just use those
> drivers, and save a lot of effort.

The GPL says "you can use them if your final new result is GPL", the BSD
world says "Hey go do it, just say thanks". Its probably a lot simpler
to use the FreeBSD code if you don't want a GPL result.

For myself I'd be willing to discuss relicensing code in some cases but
there is little that has a single author. 

Alan

