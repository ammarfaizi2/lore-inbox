Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262017AbTEFWYF (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 18:24:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262018AbTEFWYF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 18:24:05 -0400
Received: from pc2-cwma1-4-cust86.swan.cable.ntl.com ([213.105.254.86]:1411
	"EHLO lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S262017AbTEFWYD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 18:24:03 -0400
Subject: Re: Using GPL'd Linux drivers with non-GPL, binary-only kernel
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jamie Lokier <jamie@shareable.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <20030506223127.GD6284@mail.jlokier.co.uk>
References: <20030506164252.GA5125@mail.jlokier.co.uk>
	 <1052242508.1201.43.camel@dhcp22.swansea.linux.org.uk>
	 <20030506185433.GA6023@mail.jlokier.co.uk>
	 <1052250792.1983.160.camel@dhcp22.swansea.linux.org.uk>
	 <20030506223127.GD6284@mail.jlokier.co.uk>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1052257086.1201.179.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 06 May 2003 22:38:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2003-05-06 at 23:31, Jamie Lokier wrote:
> I understand the licensing in unambiguous causes, and I'm not trying
> to find loopholes in awkward corners.  I'm just observing that, as
> closed-source binary modules are de facto accepted (with some funky
> rules about which interfaces they can use), the same in reverse
> _ought_ to be accepted to the same degree: Linux (and other) GPL'd
> modules as satellites around a non-GPL kernel.

Actually at least two contributors of note disagree in the general case
about binary modules - except when the legal test holds that they are
not a derivative work. You'll find Linus comments boil down to much that
as well - the EXPORT_SYMBOL stuff is merely guidance.


