Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279080AbRJVXXB>; Mon, 22 Oct 2001 19:23:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279082AbRJVXWx>; Mon, 22 Oct 2001 19:22:53 -0400
Received: from mail215.mail.bellsouth.net ([205.152.58.155]:43514 "EHLO
	imf15bis.bellsouth.net") by vger.kernel.org with ESMTP
	id <S279080AbRJVXWk>; Mon, 22 Oct 2001 19:22:40 -0400
Message-ID: <3BD4AA6F.9E25907A@mandrakesoft.com>
Date: Mon, 22 Oct 2001 19:23:27 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: sten@blinkenlights.nl, linux-kernel@vger.kernel.org
Subject: Re: INIT_MMAP on sparc64
In-Reply-To: <20011022.152800.59654230.davem@redhat.com>
		<Pine.LNX.4.40-blink.0110230044400.20416-100000@deepthought.blinkenlights.nl> <20011022.153947.48529984.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> Turn off the PCI device names, that is usually what eats up a
> lot of space and lspci provides the same info anyways...

...after updating lspci's copy of pci.ids, of course :)

-- 
Jeff Garzik      | Only so many songs can be sung
Building 1024    | with two lips, two lungs, and one tongue.
MandrakeSoft     |         - nomeansno

