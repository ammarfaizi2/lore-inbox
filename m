Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261187AbVFDAGf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261187AbVFDAGf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Jun 2005 20:06:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261188AbVFDAGe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Jun 2005 20:06:34 -0400
Received: from pilet.ens-lyon.fr ([140.77.167.16]:9617 "EHLO
	relaissmtp.ens-lyon.fr") by vger.kernel.org with ESMTP
	id S261187AbVFDAFz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Jun 2005 20:05:55 -0400
Message-ID: <42A0F05A.8010901@ens-lyon.org>
Date: Sat, 04 Jun 2005 02:05:46 +0200
From: Brice Goglin <Brice.Goglin@ens-lyon.org>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050331)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
Cc: Sylvain Meyer <sylvain.meyer@worldonline.fr>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.12?
References: <42A0D88E.7070406@pobox.com> <20050603163843.1cf5045d.akpm@osdl.org>
In-Reply-To: <20050603163843.1cf5045d.akpm@osdl.org>
X-Enigmail-Version: 0.91.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton a écrit :
> Lots of USB problems, quite a few input problems.  fbdev, ACPI, ATAPI.  All
> the usual suspects.
> 
> Subject: intelfb crash on i845
> Subject: Re: [Linux-fbdev-devel] intelfb crash on i845

These two entries seem to be the same one, from me.
Sylvain Meyer was working on it. And I've recently seen some patches
from him on the mm-commit list. I didn't have time to test them but I
should be able to try next week (especially if a new -mm is released
soon).

Brice
