Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264767AbTFQO1N (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jun 2003 10:27:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264768AbTFQO1M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jun 2003 10:27:12 -0400
Received: from mta04bw.bigpond.com ([139.134.6.87]:27624 "EHLO
	mta04bw.bigpond.com") by vger.kernel.org with ESMTP id S264767AbTFQO1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jun 2003 10:27:07 -0400
Message-ID: <3EEF28F9.9050700@snapgear.com>
Date: Wed, 18 Jun 2003 00:43:05 +1000
From: Greg Ungerer <gerg@snapgear.com>
Organization: SnapGear
User-Agent: Mozilla/5.0 (Windows; U; Win98; en-US; rv:1.2.1) Gecko/20021130
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH]: linux-2.5.72-uc0 (MMU-less fix ups)
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Another update of the uClinux (MMU-less) fixups against 2.5.72.
Mostly carried forward from 2.5.71.

You can get it at:

http://www.uclinux.org/pub/uClinux/uClinux-2.5.x/linux-2.5.72-uc0.patch.gz


Change log:

. 2.5.72 fixups                                   (me)
. fix argument types in bitops functions          (me)
. binfmt_flat shared library support              (David McCullough)
. cleanup show_process_blocks() for nommu.c       (Bernardo Innocenti)
. DragenEngine compress loader support            (Georges Menie)


Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Chief Software Dude       EMAIL:     gerg@snapgear.com
Snapgear Pty Ltd                            PHONE:       +61 7 3279 1822
825 Stanley St,                             FAX:         +61 7 3279 1820
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com






















