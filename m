Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262104AbUBXADT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Feb 2004 19:03:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262097AbUBXADM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Feb 2004 19:03:12 -0500
Received: from mail.shareable.org ([81.29.64.88]:43906 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262104AbUBXACE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Feb 2004 19:02:04 -0500
Date: Tue, 24 Feb 2004 00:02:02 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Norman Diamond <ndiamond@wta.att.ne.jp>
Cc: linux-kernel@vger.kernel.org
Subject: Re: UTF-8 filenames
Message-ID: <20040224000202.GC1277@mail.shareable.org>
References: <18de01c3f93f$dc6d91d0$b5ee4ca5@DIAMONDLX60> <20040222204541.GA26793@mail.shareable.org> <008d01c3f99c$9033e3c0$34ee4ca5@DIAMONDLX60> <20040223115822.GA28909@mail.shareable.org> <02a201c3fa66$d4ee2190$34ee4ca5@DIAMONDLX60>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <02a201c3fa66$d4ee2190$34ee4ca5@DIAMONDLX60>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Norman Diamond wrote:
> The reason I think my checking was not useful is that I think you already
> knew that Linux didn't have it  :-)

Yes, it already came up earlier in the thread.  Linux is very likely
to get an option to make the delete key work.

> Sorry I cannot check details on which bits are used by commercial Unix
> systems.  As mentioned previously, I no longer have access to any such
> systems.  Some vendors documented the options in the "man stty" pages in
> both Japanese and English, but other vendors only documented them in the
> "man stty" page in Japanese.

Do you remember which systems you used which had English "man stty"
pages with these options?  Such pages can often be looked up online.

The reason I ask is that it makes sense for any option which is added
to Linux to copy existing options on another unix flavour, if they are
sensible.

-- Jamie
