Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbULXVGE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbULXVGE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Dec 2004 16:06:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261450AbULXVGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Dec 2004 16:06:04 -0500
Received: from mail-in-02.arcor-online.net ([151.189.21.42]:24773 "EHLO
	mail-in-02.arcor-online.net") by vger.kernel.org with ESMTP
	id S261449AbULXVGA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Dec 2004 16:06:00 -0500
From: Bodo Eggert <7eggert@gmx.de>
Subject: Re: Prezeroing V2 [3/4]: Add support for ZEROED and NOT_ZEROED free maps
To: Christoph Lameter <clameter@sgi.com>, akpm@osdl.org,
       linux-ia64@vger.kernel.org, torvalds@osdl.org, linux-mm@kvack.org,
       linux-kernel@vger.kernel.org
Reply-To: 7eggert@gmx.de
Date: Fri, 24 Dec 2004 22:10:02 +0100
References: <fa.n0l29ap.1nqg39@ifi.uio.no> <fa.n04s9ar.17sg3f@ifi.uio.no>
User-Agent: KNode/0.7.7
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8Bit
Message-Id: <E1ChwhG-00011c-00@be1.7eggert.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

> o Add scrub daemon

Please use names a simple user may understand.

What about memcleand or zeropaged instead?

¢¢
