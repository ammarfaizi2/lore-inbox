Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267546AbUHJQyJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267546AbUHJQyJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 12:54:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267589AbUHJQvv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 12:51:51 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:29082 "HELO ithnet.com")
	by vger.kernel.org with SMTP id S267546AbUHJQr3 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 12:47:29 -0400
X-Sender-Authentication: net64
Date: Tue, 10 Aug 2004 18:47:18 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: schilling@fokus.fraunhofer.de, alan@lxorguk.ukuu.org.uk, axboe@suse.de,
       diablod3@gmail.com, dwmw2@infradead.org, eric@lammerts.org,
       james.bottomley@steeleye.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040810184718.769c046f.skraw@ithnet.com>
In-Reply-To: <20040810161056.GB1127@lug-owl.de>
References: <200408101427.i7AERDld014134@burner.fokus.fraunhofer.de>
	<20040810164947.7f363529.skraw@ithnet.com>
	<20040810152458.GA1127@lug-owl.de>
	<20040810174814.414c8fdd.skraw@ithnet.com>
	<20040810161056.GB1127@lug-owl.de>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Aug 2004 18:10:57 +0200
Jan-Benedict Glaw <jbglaw@lug-owl.de> wrote:

> Actually, I use Debian since, um, long ago:)  But accept that Jörg
> doesn't really like to care about f*cked up patched versions of
> cdrecord.

He does not need to. Nobody told him to do.
Besides I doubt that only the patched versions are actually "f*cked up".
My personal experience with cdrecord is that neither version works well on my
system.
I tried several including "gods' own". Needless to mention it didn't work
either. Needless to mention he told me to upgrade the firmware, needless to
mention that did not help, but got worse instead (not even dvd worked
afterwards).
End of the story was that I gave away the old device (which works in a w*ndows
system flawlessly ever since for both CD and DVD), and bought a new one which
works well with DVD again (growisofs) but still not with cdrecord.
My personal opinion is that both product and author get more attention than
they deserve.

Regards,
Stephan
