Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264638AbUF1KFu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264638AbUF1KFu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 06:05:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264795AbUF1KFu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 06:05:50 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:23682 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S264638AbUF1KFs convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 06:05:48 -0400
To: Vojtech Pavlik <vojtech@suse.cz>
Cc: Dmitry Torokhov <dtor_core@ameritech.net>,
       Tuukka Toivonen <tuukkat@ee.oulu.fi>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/19] New set of input patches
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Date: 28 Jun 2004 12:05:45 +0200
Message-ID: <xb7d63kj8ue.fsf@savona.informatik.uni-freiburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Vojtech" == Vojtech Pavlik <vojtech@suse.cz> writes:

On Mon, Jun 28, 2004 at 12:08:21AM -0500, Dmitry Torokhov wrote:

...
> 08-serio-rebind.patch
>         - allow user to disconnect or rebind serio port by writing appropriate
>           data to it's sysfs attribute:
>               echo -n "psmouse" > /sys/bus/serio/devices/serio0/driver
>               echo -n "none" > /sys/bus/serio/devices/serio0/driver
>               echo -n "reconnect" > /sys/bus/serio/devices/serio0/driver
>               echo -n "rescan" > /sys/bus/serio/devices/serio0/driver

    Vojtech> Very good idea.

...


    >> 10-serio_raw.patch - raw access to serio data ala 2.4
    >> /dev/psaux

    Vojtech> OK, finally those who insist on /dev/psaux can shut up


Now, guess who originated these ideas!?




-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

