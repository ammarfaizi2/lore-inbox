Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932310AbWEOGYO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932310AbWEOGYO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 02:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWEOGYO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 02:24:14 -0400
Received: from mail1.kontent.de ([81.88.34.36]:18074 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S932310AbWEOGYN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 02:24:13 -0400
From: Oliver Neukum <oliver@neukum.org>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] Re: [PATCH/RFC 2.6.16.5 1/1] usb/media/quickcam_messenger driver
Date: Mon, 15 May 2006 08:24:41 +0200
User-Agent: KMail/1.8
Cc: "Jaya Kumar" <jayakumar.video@gmail.com>, linux-kernel@vger.kernel.org
References: <200605141411.k4EEBaO4022817@localhost.localdomain> <200605141824.28161.oliver@neukum.org> <70066d530605141619p40ca79c0uaa047918c11c37bb@mail.gmail.com>
In-Reply-To: <70066d530605141619p40ca79c0uaa047918c11c37bb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605150824.41289.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 15. Mai 2006 01:19 schrieb Jaya Kumar:
> On 5/15/06, Oliver Neukum <oliver@neukum.org> wrote:
> > Building this data structure on the stack is a shooting offense.
> 
> I completely agree with you (except for the shooting part :-). I'll
> make the corrections. In my defense, I copied that from the konicawc
> code.

Then you have two drivers to fix.

	Regards
		Oliver
