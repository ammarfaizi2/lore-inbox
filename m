Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269963AbTGUMQX (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jul 2003 08:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269967AbTGUMQX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jul 2003 08:16:23 -0400
Received: from tomts21.bellnexxia.net ([209.226.175.183]:63713 "EHLO
	tomts21-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S269963AbTGUMPw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jul 2003 08:15:52 -0400
Date: Mon, 21 Jul 2003 08:29:37 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
X-X-Sender: rpjday@localhost.localdomain
To: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test1: "make help" is not complete
Message-ID: <Pine.LNX.4.53.0307210827200.5101@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  just an observation -- "make help" doesn't list all possible
make options.  minimally, "make randconfig" is not listed there,
although i'm not surprised that this feature is not prominently
advertised. :-)

  there might be others as well that are not listed, i wasn't
trying to be exhaustive.

rday
