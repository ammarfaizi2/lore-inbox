Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWATQui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWATQui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 11:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751088AbWATQui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 11:50:38 -0500
Received: from wproxy.gmail.com ([64.233.184.196]:43548 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751083AbWATQuh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 11:50:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=to+zKveyMTFPbypY4qJn0Z8XMc4OC9wW8p+x62R7TOY0ObrIoI/YDeiAOA4cckx52rae55cSzir8gShQIEYNHHBNCCJDNx0lFIg+rA03tmxJufXWn5NL9DyIh0tDpY0AQLdJrC8svwM1HMwH2auBCFTwNk5+qHcuYGo4ARfhKks=
Message-ID: <d120d5000601200850w611e8af8v41a0786b7dc973d9@mail.gmail.com>
Date: Fri, 20 Jan 2006 11:50:32 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Michael Loftis <mloftis@wgops.com>
Subject: Re: Development tree, PLEASE?
Cc: James Courtier-Dutton <James@superbug.co.uk>, linux-kernel@vger.kernel.org
In-Reply-To: <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <D1A7010C56BB90C4FA73E6DD@dhcp-2-206.wgops.com>
	 <43D10FF8.8090805@superbug.co.uk>
	 <6769FDC09295B7E6078A5089@d216-220-25-20.dynip.modwest.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/20/06, Michael Loftis <mloftis@wgops.com> wrote:
>
> Well there's a whole grab bag of them that I'll be getting to over the next
> few months, but the most immediate is the fact that I've gotten new
> hardware from a venduh that requires me to build a new Debian installer and
> new debian kernels.  I also have custom packages that depend on devfs being
> there and now it's not.
>
> Yes I realise this change isn't out of the blue or anything, but it's in a
> 'stable' kernel.  Why bother calling 2.6 stable?  We may as well have
> stayed at 2.5 if this sort of thing is going to continue to be pulled.
>

Ok, so you agree that there was an ample warning that devfs is going
away... Now, what would be different if 2.8.0 released tomorrow
without devfs and your vendor would require you to build new Debian
installer and kernel?

--
Dmitry
