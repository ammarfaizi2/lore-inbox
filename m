Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129849AbRAONJp>; Mon, 15 Jan 2001 08:09:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbRAONJf>; Mon, 15 Jan 2001 08:09:35 -0500
Received: from mercury.rus.uni-stuttgart.de ([129.69.1.226]:60175 "EHLO
	mercury.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S129849AbRAONJ1>; Mon, 15 Jan 2001 08:09:27 -0500
To: Gerhard Mack <gmack@innerfire.net>
Cc: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Is sendfile all that sexy?
In-Reply-To: <Pine.LNX.4.10.10101141349210.11765-100000@innerfire.net>
From: Florian Weimer <Florian.Weimer@RUS.Uni-Stuttgart.DE>
Date: 15 Jan 2001 14:02:22 +0100
In-Reply-To: <Pine.LNX.4.10.10101141349210.11765-100000@innerfire.net>
Message-ID: <tgitnhx929.fsf@mercury.rus.uni-stuttgart.de>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gerhard Mack <gmack@innerfire.net> writes:

> PS I wish someone would explain to me why distros insist on using WU
> instead given it's horrid security record. 

The security record of Proftpd is not horrid, but embarrassing.  They
once claimed to have fixed vulnerability, but in fact introduced
another one...
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
