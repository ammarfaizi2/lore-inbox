Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265230AbUIDSOl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265230AbUIDSOl (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 14:14:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265275AbUIDSOk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 14:14:40 -0400
Received: from host-63-144-52-41.concordhotels.com ([63.144.52.41]:65502 "EHLO
	080relay.CIS.CIS.com") by vger.kernel.org with ESMTP
	id S265230AbUIDSOk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 14:14:40 -0400
Subject: Re: [BUG] r200 dri driver deadlocks
From: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
To: Patrick McFarland <diablod3@gmail.com>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org, wli@holomorphy.com
In-Reply-To: <d577e569040904021631344d2e@mail.gmail.com>
References: <d577e569040904021631344d2e@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Date: Sat, 04 Sep 2004 14:14:55 -0400
Message-Id: <1094321696.31459.103.camel@admin.tel.thor.asgaard.local>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2004-09-04 at 05:16 -0400, Patrick McFarland wrote:
> 
> All of this was tested with a virgin 2.6.8.1 (with debug info and
> frame pointers enabled) and Debian's XFree86 4.3.0.1, [...]

What version of the DRI driver?


-- 
Earthling Michel Dänzer      |     Debian (powerpc), X and DRI developer
Libre software enthusiast    |   http://svcs.affero.net/rm.php?r=daenzer
