Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279921AbRJ3L2C>; Tue, 30 Oct 2001 06:28:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279920AbRJ3L1o>; Tue, 30 Oct 2001 06:27:44 -0500
Received: from zeus.kernel.org ([204.152.189.113]:47596 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S279919AbRJ3L1d>;
	Tue, 30 Oct 2001 06:27:33 -0500
Date: Tue, 30 Oct 2001 12:23:10 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Vojtech Pavlik <vojtech@suse.cz>
cc: Alan Cox <laughing@shared-source.org>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.13-ac4
In-Reply-To: <20011029210333.A4828@suse.cz>
Message-ID: <Pine.GSO.3.96.1011030122006.6694A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Oct 2001, Vojtech Pavlik wrote:

> >  Hmm, has anyone tried using the "read back" 8254 command for latching,
> > instead?  Chances are it's less buggy... 
> 
> We can try, but I think that it's more likely to be more buggy, because
> it isn't widely used by software. And at least according to the 8254
> docs they should be equivalent in what they do.

 Are you sure it isn't used?  Do you have sources of various operating
systems to check?  I don't.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

