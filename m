Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263149AbUDMIGU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 04:06:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbUDMIGU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 04:06:20 -0400
Received: from hermine.idb.hist.no ([158.38.50.15]:37649 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP id S263149AbUDMIGT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 04:06:19 -0400
Message-ID: <407B9FB1.8070107@aitel.hist.no>
Date: Tue, 13 Apr 2004 10:07:13 +0200
From: Helge Hafting <helgehaf@aitel.hist.no>
Organization: AITeL, HiST
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031107 Debian/1.5-3
X-Accept-Language: no, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.5-mm5 devpts filesystem doesn't work
References: <20040412221717.782a4b97.akpm@osdl.org>
In-Reply-To: <20040412221717.782a4b97.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tried stepping up from 2.6.5-rc3-mm4 to 2.6.5-mm4.
This Quokka seems too zonked to work though.

It came up, but I couldn't run "xterm".  Trying from
the xemacs shell I saw an error message about not enough ptys.
I use the devpts fs mounted on /dev/pts

It mounts just fine, but doesn't work apparently.  There are no
such problems with 2.6.5-rc3-mm4

Helge Hafting

