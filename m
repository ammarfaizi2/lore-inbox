Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263709AbTDTVXq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 17:23:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263711AbTDTVXp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 17:23:45 -0400
Received: from mail1.WPI.EDU ([130.215.36.102]:12162 "EHLO mail1.WPI.EDU")
	by vger.kernel.org with ESMTP id S263709AbTDTVXp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 17:23:45 -0400
Date: Sun, 20 Apr 2003 17:35:45 -0400 (EDT)
From: Seth Britten Chandler <sethbc@WPI.EDU>
To: linux-kernel@vger.kernel.org
Subject: problem opening slave tty's in 2.5.68{-mm1}
Message-ID: <Pine.LNX.4.44.0304201734080.25559-100000@ccc9.WPI.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

i'm sure this has already been covered, but i've had problmes with my mail
recently.  Every time i try to open an {A,E,x}term i get

aterm: can't open slave tty (null)
aterm: can't open slave tty (null)

is this a known issue?  is there a workaround for this?

i'm running a gentoo box with everything up to date...


seth



