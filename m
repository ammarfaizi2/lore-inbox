Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266939AbSLWTH6>; Mon, 23 Dec 2002 14:07:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266940AbSLWTH6>; Mon, 23 Dec 2002 14:07:58 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:19214 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S266939AbSLWTH6>;
	Mon, 23 Dec 2002 14:07:58 -0500
Date: Mon, 23 Dec 2002 11:12:32 -0800
From: Greg KH <greg@kroah.com>
To: mdew <mdew@orcon.net.nz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       "torvalds@transmeta.com" <torvalds@transmeta.com>,
       Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH 2.5] [TRIVIAL] USB Joypad quirk
Message-ID: <20021223191232.GA31060@kroah.com>
References: <1040556042.9822.17.camel@nirvana>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1040556042.9822.17.camel@nirvana>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 23, 2002 at 12:20:30AM +1300, mdew wrote:
> Orginally from Vojtech Pavlik (16th June 2002 via email), to fix my
> 'broken' USB joypad, Fully tested in both 2.4.x and 2.5.52 (and
> 2.5.52-bk).

Applied to my 2.5 tree, thanks.

Can you also send a 2.4 version, as this one does not work for that
tree?

thanks,

greg k-h
