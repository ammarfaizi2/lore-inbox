Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264981AbTLRJv1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Dec 2003 04:51:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265030AbTLRJv1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Dec 2003 04:51:27 -0500
Received: from xdsl-213-168-118-128.netcologne.de ([213.168.118.128]:58712
	"EHLO herc.66h.42h.de") by vger.kernel.org with ESMTP
	id S264981AbTLRJvZ convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Dec 2003 04:51:25 -0500
Date: Thu, 18 Dec 2003 09:51:04 +0000 (UTC)
From: Thorsten Glaser <tg-v2003@netcologne.de>
To: Randy Zagar <jrzagar@cactus.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: Linux GPL and binary module exception clause?
In-Reply-To: <1071738720.25032.496.camel@otter.zagar.linux-dude.net>
Message-ID: <Pine.BSO.4.58.0312180949170.8646@herc.66h.42h.de>
References: <1071738720.25032.496.camel@otter.zagar.linux-dude.net>
X-SMIME: No
X-Message-Flag: Your mailer is broken. Get an update at http://www.washington.edu/pine/pc-pine/ for free.
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dixitur illum jrzagar@cactus.org scribere...

>As I see it, this whole problem about kernel headers revolves around the
>argument that the header files are copyrighted and licensed under the

No matter which one, but IMHO is putting a (c) on a header file
a Bad Thing(tm).

Sure, you'll need a licence to distribute it at all, but if
merely using the header file (which is just the API, written
in a compiler-parseable form) inflicts restriction on the
result, it's ridiculous. (Someone could just rewrite these
header files themselfes anyways.)

//Thorsten
-- 
Solange man keine schmutzigen Tricks macht, und ich meine *wirklich*
schmutzige Tricks, wie bei einer doppelt verketteten Liste beide
Pointer XORen und in nur einem Word speichern, funktioniert Boehm ganz
hervorragend.		-- Andreas Bogk über boehm-gc in d.a.s.r
