Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265171AbUDUHSs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265171AbUDUHSs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Apr 2004 03:18:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265185AbUDUHSs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Apr 2004 03:18:48 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:1956 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S265171AbUDUHSq convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Apr 2004 03:18:46 -0400
To: Kim Holviala <kim@holviala.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: /dev/psaux-Interface
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 21 Apr 2004 09:18:44 +0200
Message-ID: <xb7oeplg5nv.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Kim" == Kim Holviala <kim@holviala.com> writes:

    Kim> On Tuesday 20 April 2004 15:56, Dmitry Torokhov wrote:
    >> I think the right way is to fix the issues with psmouse driver
    >> and use input system to tie all hardware together.

    Kim> I agree 100%, and that's why I'm working on the driver. I
    Kim> think the biggest issue right now is the Fujitsu TouchScreen
    Kim> - I'll try to steal one of those laptops from work later this
    Kim> week and maybe come up with a solution. It has a Synaptics
    Kim> touchpad too so I get to test that as well.

So, are  you going to port  my XFree86 driver for  my touchscreen into
kernel space?


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

