Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262430AbUJ0NRu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262430AbUJ0NRu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 09:17:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262429AbUJ0NRZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 09:17:25 -0400
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:62099 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262431AbUJ0NKq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 09:10:46 -0400
Subject: Re: Strange IO behaviour on wakeup from sleep
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>, Pavel Machek <pavel@ucw.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>, Andrew Morton <akpm@osdl.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Jens Axboe <axboe@suse.de>
In-Reply-To: <1098878790.9478.11.camel@gaston>
References: <1098845804.606.4.camel@gaston>
	 <Pine.LNX.4.53.0410271308360.9839@gockel.physik3.uni-rostock.de>
	 <1098878790.9478.11.camel@gaston>
Content-Type: text/plain
Message-Id: <1098882118.4097.10.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Wed, 27 Oct 2004 23:01:58 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Wed, 2004-10-27 at 22:06, Benjamin Herrenschmidt wrote:
> The problem has been observed on ppc, while this patch only affects
> i386...

Another shot in the dark....

Nothing interesting about /proc/interrupts?

Regards,

Nigel
-- 
Nigel Cunningham
Pastoral Worker
Christian Reformed Church of Tuggeranong
PO Box 1004, Tuggeranong, ACT 2901

Everyone lives by faith. Some people just don't believe it.
Want proof? Try to prove that the theory of evolution is true.

