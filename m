Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264782AbUEaVDp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264782AbUEaVDp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 17:03:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264785AbUEaVDp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 17:03:45 -0400
Received: from simmts5.bellnexxia.net ([206.47.199.163]:62363 "EHLO
	simmts5-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S264782AbUEaVDo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 17:03:44 -0400
Date: Mon, 31 May 2004 17:03:47 -0400
From: Sean Estabrooks <seanlkml@sympatico.ca>
To: "Patrick J. LoPresti" <patl@users.sourceforge.net>
Cc: szepe@pinerecords.com, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.x partition breakage and dual booting
Message-Id: <20040531170347.425c2584.seanlkml@sympatico.ca>
In-Reply-To: <s5gaczonzej.fsf@patl=users.sf.net>
References: <40BA2213.1090209@pobox.com>
	<20040530183609.GB5927@pclin040.win.tue.nl>
	<40BA2E5E.6090603@pobox.com>
	<20040530200300.GA4681@apps.cwi.nl>
	<s5g8yf9ljb3.fsf@patl=users.sf.net>
	<20040531180821.GC5257@louise.pinerecords.com>
	<s5gaczonzej.fsf@patl=users.sf.net>
Organization: 
X-Mailer: Sylpheed version 0.9.9-gtk2-20040229 (GTK+ 2.4.0; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 May 2004 16:06:54 -0400
"Patrick J. LoPresti" <patl@users.sourceforge.net> wrote:

> The point is, if you use the wrong geometry in the partition table,
> Windows will not boot.  You could always fix it later, either from
> Linux (sfdisk hack) or from the Windows recovery console or with a hex
> editor or whatever.  The topic of discussion was how to get it right
> to begin with.

Just don't alter partition table entries of non Linux partitions?  

Cheers,
Sean
