Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129761AbQLMUee>; Wed, 13 Dec 2000 15:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129777AbQLMUeY>; Wed, 13 Dec 2000 15:34:24 -0500
Received: from u-code.de ([207.159.137.250]:33517 "EHLO u-code.de")
	by vger.kernel.org with ESMTP id <S129761AbQLMUeI>;
	Wed, 13 Dec 2000 15:34:08 -0500
From: Eckhard Jokisch <e.jokisch@u-code.de>
Reply-To: e.jokisch@u-code.de
To: linux-kernel@vger.kernel.org
Subject: Re: [Solved]IDE_TAPE problem with ONSTREAM DI30
Date: Wed, 13 Dec 2000 21:05:10 +0000
X-Mailer: KMail [version 1.1.61]
Content-Type: text/plain; charset=US-ASCII
In-Reply-To: <Pine.LNX.4.10.10012032315100.13699-100000@master.linux-ide.org> <200012040825.JAA08264@cave.bitwizard.nl> <20001204160554.L6281@garloff.etpnet.phys.tue.nl>
In-Reply-To: <20001204160554.L6281@garloff.etpnet.phys.tue.nl>
Cc: Kurt Garloff <garloff@suse.de>
MIME-Version: 1.0
Message-Id: <00121321051000.22766@eckhard>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 04 Dez 2000, Kurt Garloff wrote:

>
> If you want a really helpful advice:
> Use the osst driver and the use it with ide-scsi.
> Report problems to the osst mailing list.
> So far, I'm not aware of anybody we failed to help.
> http://linux1.onstream.nl/test/

This was really really helpfull :-)
It just works fine now.

Wouldn't it be good to put a slight hint somewhere in the kernel 
configuration?

BR
Eckhard Jokisch
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
