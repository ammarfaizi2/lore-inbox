Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129170AbRBUV5P>; Wed, 21 Feb 2001 16:57:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129379AbRBUV5F>; Wed, 21 Feb 2001 16:57:05 -0500
Received: from pizda.ninka.net ([216.101.162.242]:6272 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129170AbRBUV4r>;
	Wed, 21 Feb 2001 16:56:47 -0500
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14996.14604.348038.42765@pizda.ninka.net>
Date: Wed, 21 Feb 2001 13:54:20 -0800 (PST)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: mager@tzi.de (Markus Germeier), linux-kernel@vger.kernel.org
Subject: Re: Problem with 2.2.19pre9 (Connection closed.)
In-Reply-To: <E14VZCs-00023R-00@the-village.bc.nu>
In-Reply-To: <94ae7g9o8t.fsf@religion.informatik.uni-bremen.de>
	<E14VZCs-00023R-00@the-village.bc.nu>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan Cox writes:
 > Dave - any ideas, shall we back it out and work on it for 2.2.20 ?

The one change which is probably causing this is non-critical,
so let me study things quickly tonight and if I come up with
nothing I'll show you what you can revert safely.

Later,
David S. Miller
davem@redhat.com
