Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131523AbRABTYM>; Tue, 2 Jan 2001 14:24:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131369AbRABTYB>; Tue, 2 Jan 2001 14:24:01 -0500
Received: from sundiver.zdv.Uni-Mainz.DE ([134.93.174.136]:5892 "HELO
	gateway.intern.kubla.de") by vger.kernel.org with SMTP
	id <S130172AbRABTX6>; Tue, 2 Jan 2001 14:23:58 -0500
Date: Tue, 2 Jan 2001 19:53:22 +0100
From: Dominik Kubla <dominik.kubla@uni-mainz.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Happy new year^H^H^H^Hkernel..
Message-ID: <20010102195322.A11142@uni-mainz.de>
Mail-Followup-To: Dominik Kubla <dominik.kubla@uni-mainz.de>,
	Linus Torvalds <torvalds@transmeta.com>,
	Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.10.10012311205020.1210-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <Pine.LNX.4.10.10012311205020.1210-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Sun, Dec 31, 2000 at 12:24:44PM -0800
X-No-Archive: yes
Restrict: no-external-archive
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 31, 2000 at 12:24:44PM -0800, Linus Torvalds wrote:
...
> Give it your worst. After you recover from being hung-over, of course.
> 
> 			Linus

Dell Inspiron 7500VT (Pentium-II 400, 128 MB RAM, BIOS A14): no go when
ACPI is enabled. System hangs after the

  ACPI: System description tables loaded

message.  System boots fine with APM, but the Xircom Combi-Card (not
using the kernel drivers!) does not work. Will try with kernel drivers
ASAP.

Yours,
  Dominik Kubla
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
