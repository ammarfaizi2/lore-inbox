Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265532AbRGEXJB>; Thu, 5 Jul 2001 19:09:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265548AbRGEXIw>; Thu, 5 Jul 2001 19:08:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:63246 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S265501AbRGEXIe>; Thu, 5 Jul 2001 19:08:34 -0400
Subject: Re: linux/macros.h(new) and linux/list.h(mod) ...
To: mdharm-kernel@one-eyed-alien.net (Matthew Dharm)
Date: Fri, 6 Jul 2001 00:07:13 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), dwmw2@infradead.org (David Woodhouse),
        phillips@bonn-fries.net (Daniel Phillips),
        davidel@xmailserver.org (Davide Libenzi), linux-kernel@vger.kernel.org
In-Reply-To: <20010705160534.A17113@one-eyed-alien.net> from "Matthew Dharm" at Jul 05, 2001 04:05:34 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15IIDJ-0003Ux-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Better, but throwing __FILE__ in there would be good too...

Totally inappropriate. These are not global variables and a filename is not
legal variable namespace anyway

