Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263884AbTDNVfp (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:35:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263901AbTDNVfo (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:35:44 -0400
Received: from zeke.inet.com ([199.171.211.198]:58281 "EHLO zeke.inet.com")
	by vger.kernel.org with ESMTP id S263884AbTDNVez (for <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Apr 2003 17:34:55 -0400
Message-ID: <3E9B2C38.4020405@inet.com>
Date: Mon, 14 Apr 2003 16:46:32 -0500
From: Eli Carter <eli.carter@inet.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20021003
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: [OT] patch splitting util(s)?
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A bit off-topic, but something tangentally related to this list...

Is anyone aware of a utility that helps with splitting a (large) patch 
into multiple patches at a hunk (or better, a sub-hunk) level?

I'm visualizing a GUI (or similar) that lets you right-click on a hunk 
and get a list of sub-patches or the option to create a new sub-patch, 
and moves the hunk to the selected sub-patch.  (I use the term 
'sub-patch', but in theory, you could load a set of patches, then 
shuffle hunks around.)  And lets you go to the sub-patches and move 
hunks from there to another patch.

A vim or emacs script/plugin would probably make the most sense.  (I'm a 
vim user, so I'm not familiar with what emacs provides, but I didn't see 
this functionality after a very quick look.)

I didn't have much luck with googling.  I think the words I used are too 
generic.  :/

Anyone know of something like this?

TIA,

Eli
--------------------. "If it ain't broke now,
Eli Carter           \                  it will be soon." -- crypto-gram
eli.carter(a)inet.com `-------------------------------------------------

