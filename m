Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261968AbRE3Tvk>; Wed, 30 May 2001 15:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261948AbRE3Tva>; Wed, 30 May 2001 15:51:30 -0400
Received: from [192.48.153.1] ([192.48.153.1]:45636 "EHLO sgi.com")
	by vger.kernel.org with ESMTP id <S261942AbRE3TvY>;
	Wed, 30 May 2001 15:51:24 -0400
Message-ID: <3B154E43.3CFF2618@sgi.com>
Date: Wed, 30 May 2001 12:47:15 -0700
From: LA Walsh <law@sgi.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, en-US, en-GB, fr
MIME-Version: 1.0
To: Marcus Meissner <mm@ns.caldera.de>
CC: Edsel Adap <edsel@adap.org>, linux-kernel@vger.kernel.org
Subject: Re: ln -s broken on 2.4.5
In-Reply-To: <200105301923.f4UJNl815303@ns.caldera.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcus Meissner wrote:

> $ ln -s fupp/bar bar
> $ ls -la bar

---
    Is it peculiar to a specific architecture?
    What does strace show for args to the symlink cmd?
-l
--
The above thoughts and           | They may have nothing to do with
writings are my own.             | the opinions of my employer. :-)
L A Walsh                        | Trust Technology, Core Linux, SGI
law@sgi.com                      | Voice: (650) 933-5338


