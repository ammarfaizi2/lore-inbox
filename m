Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263945AbUACU4S (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 3 Jan 2004 15:56:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263946AbUACU4S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 3 Jan 2004 15:56:18 -0500
Received: from smtp-send.myrealbox.com ([192.108.102.143]:63409 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id S263945AbUACU4S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 3 Jan 2004 15:56:18 -0500
Message-ID: <3FF72A4C.2040404@myrealbox.com>
Date: Sat, 03 Jan 2004 12:47:08 -0800
From: walt <wa1ter@myrealbox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040103
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
CC: linux-kernel@vger.kernel.org
Subject: Technical udev question for Greg
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

I think I acidentally screwed up by running a script which ran MAKEDEV
while udev was running.

Now /dev/.udev.tdb is very large and devices have strange permissions
they didn't have before.

All I want to do is delete all the extraneous devices in .udev.tdb
and start over.  How do I do that?

Thanks!
