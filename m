Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932151AbWDYI7f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932151AbWDYI7f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 04:59:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932153AbWDYI7f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 04:59:35 -0400
Received: from linux01.gwdg.de ([134.76.13.21]:54958 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S932151AbWDYI7e (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 04:59:34 -0400
Date: Tue, 25 Apr 2006 10:59:30 +0200 (MEST)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Martin Mares <mj@ucw.cz>
cc: David Schwartz <davids@webmaster.com>,
       "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Subject: Re: C++ pushback
In-Reply-To: <mj+md-20060425.085309.25473.atrey@ucw.cz>
Message-ID: <Pine.LNX.4.61.0604251058280.26791@yvahk01.tjqt.qr>
References: <mj+md-20060424.201044.18351.atrey@ucw.cz>
 <MDEHLPKNGKAHNMBLJOLKGEDHLIAB.davids@webmaster.com> <mj+md-20060425.085309.25473.atrey@ucw.cz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> 	I don't recall anyone asking you to so much as lift a finger. Feel free to
>> invest your effort where you feel it will do the most good, and try not to
>> criticize others for doing the same with their own resources.
>
>As far as they intend to stay away from the main kernel tree, I don't
>critize anybody. But for example renaming otherwise logically named structure
>members (`class' etc.) just for C++ compatibility _IS_ wasting time of
>other people, who need to remember new names, review the patch and so on.
>
That said, VMware does use C++ in its kernel modules at one point. So, it 
is possible to some degree with enough effort. Of the
C++ kernel module writer, that is!


Jan Engelhardt
-- 
