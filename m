Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261764AbTJRRyr (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 13:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261768AbTJRRyr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 13:54:47 -0400
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:5761
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S261764AbTJRRyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 13:54:33 -0400
From: John Mock <kd6pag@qsl.net>
To: linux-kernel@vger.kernel.org
Subject: re: software suspend / 2.6.0-test7,8
Message-Id: <E1AAvHj-0000zH-00@penngrove.fdns.net>
Date: Sat, 18 Oct 2003 10:54:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Software suspend (both flavors) works to me, under limited circumstances
and with X, only using VESA rather than native mode.  Note that it seems to
get confused if ones swap partition doesn't have a valid signature.  Lots
of other things could be going on.

I'm not sure how helpful these remarks are, as software suspend appears to
be somewhat hardware dependent and you haven't provided any information on
your hardware or software configuration.  You'll probably need to provide
more information to get a useful response here.  It is alot to read in its
entirety, but please have a look at relevant parts of the FAQ:

	http://www.kernel.org/pub/linux/docs/lkml/

which may be helpful in understanding what to include.  (I'm relatively new 
to this list, so i'm not sure what else to suggest.)

				   -- JM
