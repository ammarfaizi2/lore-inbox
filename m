Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269043AbUJQEl7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269043AbUJQEl7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 00:41:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269056AbUJQEl7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 00:41:59 -0400
Received: from rwcrmhc12.comcast.net ([216.148.227.85]:28327 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S269043AbUJQEl6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 00:41:58 -0400
Message-ID: <4171F7CB.9030104@biomail.ucsd.edu>
Date: Sat, 16 Oct 2004 21:40:43 -0700
From: John Gilbert <jgilbert@biomail.ucsd.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: U4 + reiserfs problems
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I'm not able to get 2.6.9rc4mm1U4 booted up, it seems to get stuck 
spitting out endless messages when the bootup process gets to the 
reiserfs check stage.  U3 seemed to get out of this mode in just a few 
seconds.

If KGDB works with this, I can try to get a log of these messages Monday 
if that will help.
Back to playing with U3 for me for now.

John G.
jgilbert@biomail.ucsd.edu
