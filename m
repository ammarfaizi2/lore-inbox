Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261375AbVCBXsd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261375AbVCBXsd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 18:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261313AbVCBXfZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 18:35:25 -0500
Received: from reverendtimms.isu.mmu.ac.uk ([149.170.192.65]:33178 "EHLO
	reverendtimms.isu.mmu.ac.uk") by vger.kernel.org with ESMTP
	id S261355AbVCBXbs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 18:31:48 -0500
From: David Johnson <dj@david-web.co.uk>
To: linux-kernel@vger.kernel.org
Subject: Re: Keyboard broken on Inspiron 5150 with 2.6.11
Date: Wed, 2 Mar 2005 22:33:12 +0000
User-Agent: KMail/1.7.1
References: <200503022135.16575.dj@david-web.co.uk> <d120d50005030214037e7531cb@mail.gmail.com>
In-Reply-To: <d120d50005030214037e7531cb@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200503022233.12913.dj@david-web.co.uk>
X-MMU-Signature: 882ebab52a0f830be1832cc65aa07dd1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 Mar 2005 22:03, Dmitry Torokhov wrote:
> On Wed, 2 Mar 2005 21:35:16 +0000, David Johnson <dj@david-web.co.uk> wrote:
> > Hi all,
> >
> > I've just booted 2.6.11 and the keyboard on my Dell Inspiron 5150 laptop
> > doesn't work at all. I've not tried the -rc versions, but it works fine
> > with 2.6.10.
>
> Does it work if you boot with i8042.noacpi boot option? And what about
> your touchpad?

Ah yes, it works perfectly with that boot option.

I can't check the touchpad as X won't start when the option isn't passed 
(maybe because touchpad device doesn't exist, but I can't check the X log).

Regards,
David.

-- 
David Johnson
http://www.david-web.co.uk/
http://www.penguincomputing.co.uk/
