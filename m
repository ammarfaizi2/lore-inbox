Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277048AbRJVQm5>; Mon, 22 Oct 2001 12:42:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277053AbRJVQms>; Mon, 22 Oct 2001 12:42:48 -0400
Received: from hera.cwi.nl ([192.16.191.8]:3805 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id <S277048AbRJVQme>;
	Mon, 22 Oct 2001 12:42:34 -0400
From: Andries.Brouwer@cwi.nl
Date: Mon, 22 Oct 2001 16:39:21 GMT
Message-Id: <UTC200110221639.QAA184571.aeb@cwi.nl>
To: linux-kernel@vger.kernel.org, moz@compsoc.man.ac.uk
Subject: Re: Making diff(1) of linux kernels faster
Cc: p_gortmaker@yahoo.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Who's the maintainer for "diff" these days?

> afaict, there is no maintainer.
> The stated maintainer has been ignoring patches for years.

-rw-r--r--   1 aeb        312312 Oct  2  1994 diffutils-2.7.tar.gz

Yes, if that is the latest, that is old.

I wouldn't mind adding diff to util-linux until
the FSF maintainer wakes up.

(Am using a modified diff myself - one that doesn't give
a lot of output for diff after a successful cp -a,
and does not get into a loop when /etc/net is a symlink to /etc.)

Andries

[But try the FSF first. Is it Paul Eggert?]
