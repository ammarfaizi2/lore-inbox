Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263269AbTDVQJN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:09:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263272AbTDVQJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:09:13 -0400
Received: from host-62-245-209-215.customer.m-online.net ([62.245.209.215]:25480
	"EHLO frodo.midearth.frodoid.org") by vger.kernel.org with ESMTP
	id S263269AbTDVQJM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:09:12 -0400
To: linux-kernel@vger.kernel.org
Subject: kernel ring buffer accessible by users
From: Julien Oster <frodo@dereference.de>
Organization: FRODOID.ORG
X-Face: #C"_SRmka_V!KOD9IoD~=}8-P'ekRGm,8qOM6%?gaT(k:%{Y+\Cbt.$Zs<[X|e)<BNuB($kI"KIs)dw,YmS@vA_67nR]^AQC<w;6'Y2Uxo_DT.yGXKkr/s/n'Th!P-O"XDK4Et{`Di:l2e!d|rQoo+C6)96S#E)fNj=T/rGqUo$^vL_'wNY\V,:0$q@,i2E<w[_l{*VQPD8/h5Y^>?:O++jHKTA(
Date: Tue, 22 Apr 2003 18:21:16 +0200
Message-ID: <frodoid.frodo.87wuhmh5ab.fsf@usenet.frodoid.org>
User-Agent: Gnus/5.090018 (Oort Gnus v0.18) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hello,

it's been quite a while that I noticed that any ordinary user, not
just root, can type "dmesg" to see the kernel ring buffer.

My question now is: Why? I often saw things in the kernel ring buffer
which I don't want every user to know (e.g. some telephone numbers with
ISDN).

Are there any problems in just letting root get the contents of the
kernel ring buffer?

Julien
