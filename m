Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751665AbWCYScM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751665AbWCYScM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 13:32:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751668AbWCYScM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 13:32:12 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:64442 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751058AbWCYScM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 13:32:12 -0500
Date: Sat, 25 Mar 2006 19:32:00 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       torvalds@osdl.org
Subject: Re: [PATCH] Fix console utf8 composing (F)
In-Reply-To: <Pine.LNX.4.61.0603221654460.7899@yvahk01.tjqt.qr>
Message-ID: <Pine.LNX.4.61.0603251931230.29793@yvahk01.tjqt.qr>
References: <Pine.LNX.4.61.0603202048350.14231@yvahk01.tjqt.qr>
 <441F7962.9080803@ums.usu.ru> <Pine.LNX.4.61.0603221654460.7899@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alex,

On Mar 22 2006 16:56, Jan Engelhardt wrote:
>>> can we have the patch[2] from this[1] thread merged? I have not yet heard
>>> back
>>> from Alexander since [3]. Plus we're lacking a Signed-off-by so far for
>>> [2].
>>> What to do?
>>> 
>> See the updated (in fact, just rediffed after "patch -Np1 -l") patch below. You
>> certainly want to run Lindent after patching.
>
>Looks good enough that I don't think Lindenting is required.
>
>

Well, no objection to style?



Jan Engelhardt
-- 
