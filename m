Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263095AbUDUIN1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263095AbUDUIN1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 04:13:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUDUIN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 04:13:27 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:59305 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S263095AbUDUINZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 04:13:25 -0400
To: Kim Holviala <kim@holviala.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
References: <xb7oeplg5nv.fsf@savona.informatik.uni-freiburg.de>
	<200404211021.26210.kim@holviala.com>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 21 Apr 2004 10:13:23 +0200
In-Reply-To: <200404211021.26210.kim@holviala.com>
Message-ID: <xb7fzaxg34s.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kim" == Kim Holviala <kim@holviala.com> writes:

    >>  So, are you going to port my XFree86 driver for my touchscreen
    >> into kernel space?

    Kim> That's what I was thinking.. I had one of those laptops a
    Kim> year ago from work, but I gave it away since the keyboard
    Kim> started acting and the touchscreen filter on top of the
    Kim> normal TFT looked too blurry to me...

    Kim> But yes, if and when I get an extra Lifebook I'll look into
    Kim> porting your driver.

Mine  is  a Lifebook  B142,  not  the  newest ones.   The  touchscreen
hardware may thus be different.

Moreover, I implemented features in my drivers which require timeouts.
That'd be too complicated for me to program in kernel space.


The driver can be downloaded from:

http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/lifebook20010712.tgz


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

