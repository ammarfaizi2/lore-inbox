Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132734AbRBEELi>; Sun, 4 Feb 2001 23:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132750AbRBEEL3>; Sun, 4 Feb 2001 23:11:29 -0500
Received: from fisica.ufpr.br ([200.17.209.129]:7158 "EHLO
	hoggar.fisica.ufpr.br") by vger.kernel.org with ESMTP
	id <S132734AbRBEELU>; Sun, 4 Feb 2001 23:11:20 -0500
From: Carlos Carvalho <carlos@fisica.ufpr.br>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <14974.10199.89722.67460@hoggar.fisica.ufpr.br>
Date: Mon, 5 Feb 2001 02:11:03 -0200
To: Adrian Chung <adrian@enfusion-group.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Dual Promise Ultra66 PCI Cards
In-Reply-To: <20010204155354.A2674@toad>
In-Reply-To: <20010204155354.A2674@toad>
X-Mailer: VM 6.90 under Emacs 19.34.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Chung (adrian@enfusion-group.com) wrote on 4 February 2001 15:53:
 >I've been attempting to get two Promise Ultra66 controllers working
 >with an Asus P2B-F motherboard.  I've got one controller successfully
 >working, but as soon as I stick the second controller in the computer,
 >the system refuses to boot.
 >
 >With 2.2.18 and the linux-ide patches (Uniform E-IDE 6.30), the
 >computer refuses to boot if there are no bootable drives on the
 >motherboard's IDE controllers.

The same happens with a P2B-DS. It has nothing to do with the kernel,
the bios doesn't try to boot (from floppy in my case).
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
