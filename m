Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129134AbRBMQcI>; Tue, 13 Feb 2001 11:32:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129467AbRBMQb7>; Tue, 13 Feb 2001 11:31:59 -0500
Received: from ns.linking.ee ([195.222.24.241]:20487 "EHLO ns.linking.ee")
	by vger.kernel.org with ESMTP id <S129134AbRBMQbx>;
	Tue, 13 Feb 2001 11:31:53 -0500
Date: Tue, 13 Feb 2001 18:31:37 +0200 (GMT-2)
From: Elmer Joandi <elmer@linking.ee>
To: "Dunlap, Randy" <randy.dunlap@intel.com>
cc: linux-kernel@vger.kernel.org
Subject: RE: USB mouse jumping
In-Reply-To: <D5E932F578EBD111AC3F00A0C96B1E6F07DBE042@orsmsx31.jf.intel.com>
Message-ID: <Pine.LNX.4.21.0102131826560.24796-100000@ns.linking.ee>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Feb 2001, Dunlap, Randy wrote:

> 
> If USB mice had serial numbers (like some USB storage devices
> do), then we could tell that it's the same mouse on the
> same connector and not change from mouse0 to mouse1.
> Currently it looks like a new device attachment.
> 
> One possible solution is for you to use /dev/usb/mice,
> which is all USB mice merged into one input stream.


Please, if it is possible, make it simple and sensible.

if to have true multihead, with 5 keyboards and mice, I would really wish
that the device numbers are connected to physical holes for plugs,
otherwise anyone (of schoolchildren for example) can do simple nasty
stupid things.

And also it is the dream for true dumbuser with one mouse, because it then
just works out of box.

Or you tell that with USB internal design you can not know physical
connector unique number ?


elmer.



