Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129080AbRBOXmu>; Thu, 15 Feb 2001 18:42:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129107AbRBOXmk>; Thu, 15 Feb 2001 18:42:40 -0500
Received: from jalon.able.es ([212.97.163.2]:18321 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S129080AbRBOXmb>;
	Thu, 15 Feb 2001 18:42:31 -0500
Date: Fri, 16 Feb 2001 00:42:19 +0100
From: "J . A . Magallon" <jamagallon@able.es>
To: Chip Salzenberg <chip@valinux.com>
Cc: "Justin T . Gibbs" <gibbs@scsiguy.com>, linux-kernel@vger.kernel.org
Subject: Re: aic7xxx (and sym53c8xx) plans
Message-ID: <20010216004219.G995@werewolf.able.es>
In-Reply-To: <85F1402515F13F498EE9FBBC5E07594220AD85@TTGCS.teamtoolz.net> <200102151747.f1FHlDO64938@aslan.scsiguy.com> <20010215212007.A995@werewolf.able.es> <20010215122836.B30852@valinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20010215122836.B30852@valinux.com>; from chip@valinux.com on Thu, Feb 15, 2001 at 21:28:36 +0100
X-Mailer: Balsa 1.1.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 02.15 Chip Salzenberg wrote:
> According to J . A . Magallon:
> 
> Might I suggest that Justin imitate the maintainers of lm_sensors, and
> create a program (shell script, Perl program, whatever) that *creates*
> a patch against any given Linux source tree?  Obviously it could break
> in the face of weird trees, but even minimal flexibility would save him
> a lot of work ...

So you can end with 1Mb of patch doing

-#endif /* Hello */
+#endif Hello

like happens in i2c-lm

Better a real patch...
 
-- 
J.A. Magallon                                                      $> cd pub
mailto:jamagallon@able.es                                          $> more beer

Linux werewolf 2.4.1-ac14 #1 SMP Thu Feb 15 16:05:52 CET 2001 i686

