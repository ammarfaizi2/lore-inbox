Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265277AbTABBWm>; Wed, 1 Jan 2003 20:22:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265285AbTABBWm>; Wed, 1 Jan 2003 20:22:42 -0500
Received: from itg-gw.cr008.cwt.esat.net ([193.120.242.226]:37127 "EHLO
	dunlop.admin.ie.alphyra.com") by vger.kernel.org with ESMTP
	id <S265277AbTABBWl>; Wed, 1 Jan 2003 20:22:41 -0500
Date: Thu, 2 Jan 2003 01:29:59 +0000 (GMT)
From: Paul Jakma <paulj@alphyra.ie>
X-X-Sender: paulj@dunlop.admin.ie.alphyra.com
To: David Lang <david.lang@digitalinsight.com>
cc: Paul Jakma <paul@clubi.ie>, Rik van Riel <riel@conectiva.com.br>,
       <Hell.Surfers@cwctv.net>, <linux-kernel@vger.kernel.org>, <rms@gnu.org>
Subject: Re: Why is Nvidia given GPL'd code to use in closed source drivers?
In-Reply-To: <Pine.LNX.4.44.0301011706400.21656-100000@dlang.diginsite.com>
Message-ID: <Pine.LNX.4.44.0301020126060.30005-100000@dunlop.admin.ie.alphyra.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 1 Jan 2003, David Lang wrote:

> well libc uses the kernel headers and basicly all userspace programs
> use libc so that makes oracle a derivitive work of the kernel??????

libc neednt neccessarily use the kernel headers, it needs to use only 
headers that are compatible. Also, though it might use kernel headers, 
the headers it provides for other programmes to be compiled against it 
are not kernel headers.

further, the kernel's licence explicitely exempts the 'normal system 
calls', and kernel headers describing these can quite arguably be 
considered to fall within this exemption.

> luckly that's not how things actually work.

unfortunately, its not at all clear.

> David Lang

regards,
-- 
Paul Jakma	Sys Admin	Alphyra
	paulj@alphyra.ie
Warning: /never/ send email to spam@dishone.st or trap@dishone.st

