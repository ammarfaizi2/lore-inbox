Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312447AbSCYP5p>; Mon, 25 Mar 2002 10:57:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312442AbSCYP5f>; Mon, 25 Mar 2002 10:57:35 -0500
Received: from dell-paw-3.cambridge.redhat.com ([195.224.55.237]:38384 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S312447AbSCYP5X>; Mon, 25 Mar 2002 10:57:23 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <200203251544.g2PFiaV02011@localhost.localdomain> 
To: James Bottomley <James.Bottomley@HansenPartnership.com>
Cc: linux-kernel@vger.kernel.org, marcelo@conectiva.com.br, lm@bitmover.com
Subject: Re: linux-2.4 bitkeeper repository not up to date 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Mar 2002 15:57:14 +0000
Message-ID: <22088.1017071834@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James.Bottomley@HansenPartnership.com said:
> The repository linux24.bkbits.net is only at 2.4.19-pre3; however, the
> kernel  test directory is at 2.4.19-pre4.  I seem to remember that
> when we had this  problem with the 2.5 repository it was a scripting
> issue.

Use linux.bkbits.net/linux-2.4 instead. 

We should probably remove linux24.bkbits.net. Marcelo? Larry?

--
dwmw2


