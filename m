Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265003AbRGQFgb>; Tue, 17 Jul 2001 01:36:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267433AbRGQFgW>; Tue, 17 Jul 2001 01:36:22 -0400
Received: from mailhost.nmt.edu ([129.138.4.52]:8965 "EHLO mailhost.nmt.edu")
	by vger.kernel.org with ESMTP id <S265003AbRGQFgE>;
	Tue, 17 Jul 2001 01:36:04 -0400
Date: Mon, 16 Jul 2001 23:36:07 -0600
From: Val Henson <val@nmt.edu>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: RFC: Remove swap file support
Message-ID: <20010716233606.A16900@boardwalk>
In-Reply-To: <3B472C06.78A9530C@mandrakesoft.com> <3B4D5158.E125A487@fabbione.net> <3B4DAC1B.D9368E51@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3B4DAC1B.D9368E51@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Thu, Jul 12, 2001 at 09:54:35AM -0400
Favorite-Color: Polka dot
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 12, 2001 at 09:54:35AM -0400, Jeff Garzik wrote:
> 
> Re-read my message.  I do not say get rid of swap files, only swap file
> code.  You can use loop for swap files.

Consider how often loop (doesn't) work.  Maybe doing this will
motivate people to keep loop working - or maybe they'll switch back to
swap partitions.

-VAL
