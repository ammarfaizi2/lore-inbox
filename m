Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274627AbRJTV5j>; Sat, 20 Oct 2001 17:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274520AbRJTV5a>; Sat, 20 Oct 2001 17:57:30 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S274669AbRJTV5X>; Sat, 20 Oct 2001 17:57:23 -0400
Subject: Re: Input on the Non-GPL Modules
To: jan@gondor.com (Jan Niehusmann)
Date: Sat, 20 Oct 2001 23:04:11 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20011018183217.A5055@gondor.com> from "Jan Niehusmann" at Oct 18, 2001 06:32:17 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15v4Dz-0002VM-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> What prevents the author of a non-GPL module who needs access to a
> GPL-only symbol from writing a small GPLed module which imports the 
> GPL-only symbol (this is allowed, because the small module is GPL), 
> and exports a basically identical symbol without the GPL-only
> restriction?

The fact that it ends up GPL'd to be linked (legal derivative work sense)
to the GPL'd code so you can link it to either but not both at the same time
