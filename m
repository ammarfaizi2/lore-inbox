Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272141AbTG1Bul (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Jul 2003 21:50:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272139AbTG1ABf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Jul 2003 20:01:35 -0400
Received: from zeus.kernel.org ([204.152.189.113]:31477 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S272934AbTG0XBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Jul 2003 19:01:37 -0400
Message-ID: <3F242B35.8050400@Synopsys.COM>
Date: Sun, 27 Jul 2003 21:42:45 +0200
From: Harald Dunkel <harri@synopsys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.0-test2
References: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307271003360.3401-100000@home.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks,

Linus Torvalds wrote:
> Lots of small updates and fixes all over the map (diffstat shows a flat
> profile, except for the DVB merge, the new wl3501 driver, and the new
> sound drivers from Alan).
> 

Probably not that important, but would it be possible to make
all files readable (chmod a+r) before creating the new kernel
tar file? At least the files in the Documentation and the include
directory?


Many thanx

Harri

