Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268723AbUHZL2L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268723AbUHZL2L (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 07:28:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268766AbUHZLSx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 07:18:53 -0400
Received: from mail1.kontent.de ([81.88.34.36]:3498 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268727AbUHZLPu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 07:15:50 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Tuukka Toivonen <tuukkat@ee.oulu.fi>
Subject: Re: [linux-usb-devel] Re: kernel 2.6.8 pwc patches and counterpatches
Date: Thu, 26 Aug 2004 13:17:18 +0200
User-Agent: KMail/1.6.2
Cc: Simon Oosthoek <simon@ti-wmc.nl>, linux-usb-devel@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, "Nemosoft Unv." <nemosoft@smcc.demon.nl>
References: <1092793392.17286.75.camel@localhost> <cgi65a$s76$1@sea.gmane.org> <Pine.GSO.4.61.0408261201490.16780@stekt37>
In-Reply-To: <Pine.GSO.4.61.0408261201490.16780@stekt37>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200408261317.18781.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 26. August 2004 11:22 schrieb Tuukka Toivonen:
> Besides, format conversions _are not allowed_ in the kernel. They belong 
> into userspace.

Well, there's no need to be dogmatic about it. In a basic sense any driver
is performing a format conversion.

> Nemosoft: you should not have the power to demand removing the GPL'd code
> from the kernel (I don't know about the law, but whatever it says, GPL'd 
> license should not be revocable). You can ask, of course, but wouldn't it 
> be simpler to just stop maintaining the in-kernel driver, if it already 
> works?

Legally of course the license has been given and cannot unilaterally be
revoked. But his name is on the driver and he gets the mails about it.
So unless somebody takes over full maintenance, he should be allowed
to shoot his own dog and Greg has announced that he would take such a
patch.

	Regards
		Oliver
