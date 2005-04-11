Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVDKQKN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVDKQKN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 12:10:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVDKQJJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 12:09:09 -0400
Received: from faui3es.informatik.uni-erlangen.de ([131.188.33.16]:24724 "EHLO
	faui3es.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261827AbVDKQHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 12:07:47 -0400
Message-Id: <20050411155806.754650000@faui31y>
Date: Mon, 11 Apr 2005 17:58:06 +0200
From: Martin Waitz <tali@admingilde.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [patch 0/2] DocBook xmlto fixes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hoi :)

the following two patches fix some problems noticed by Alexey.
I still have to look harder at the stylesheets to get nicely linked
function lists in the toc.

@Andrew: lets test the xmlto converter in -mm a little bit longer.
Should I keep sending relative patches or replacement patches?
I guess we want to collapse patches before sending to Linus.
(The patches before the xmlto one should be non-problematic and
could be commited once Linus starts accepting patches again.)

--
Martin Waitz
