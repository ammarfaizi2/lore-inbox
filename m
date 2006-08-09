Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030603AbWHIJhs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030603AbWHIJhs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 05:37:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030611AbWHIJhs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 05:37:48 -0400
Received: from thebsh.namesys.com ([212.16.7.65]:7607 "HELO thebsh.namesys.com")
	by vger.kernel.org with SMTP id S1030603AbWHIJhr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 05:37:47 -0400
Message-ID: <44D99ED9.1030003@namesys.com>
Date: Wed, 09 Aug 2006 02:37:45 -0600
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.13) Gecko/20060417
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: David Masover <ninja@slaphack.com>,
       "Horst H. von Brand" <vonbrand@inf.utfsm.cl>,
       Bernd Schubert <bernd-schubert@gmx.de>, reiserfs-list@namesys.com,
       Jan-Benedict Glaw <jbglaw@lug-owl.de>,
       Clay Barnes <clay.barnes@gmail.com>,
       Rudy Zijlstra <rudy@edsons.demon.nl>,
       Adrian Ulrich <reiser4@blinkenlights.ch>, ipso@snappymail.ca,
       lkml@lpbproductions.com, jeff@garzik.org, tytso@mit.edu,
       linux-kernel@vger.kernel.org
Subject: Re: the " 'official' point of view" expressed by kernelnewbies.org
 regarding reiser4 inclusion
References: <200608011428.k71ESIuv007094@laptop13.inf.utfsm.cl> <44CF87E6.1050004@slaphack.com> <20060806225912.GC4205@ucw.cz>
In-Reply-To: <20060806225912.GC4205@ucw.cz>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:

>
>
>Yes, I'm afraid redundancy/checksums kill write speed,
>
they kill write speed to cache, but not to disk....  our compression
plugin is faster than the uncompressed plugin.....

