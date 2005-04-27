Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262005AbVD0UjZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262005AbVD0UjZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 16:39:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262004AbVD0UjZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 16:39:25 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:12010 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S262001AbVD0UjT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 16:39:19 -0400
Date: Wed, 27 Apr 2005 22:39:18 +0200
From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
To: linux-kernel@vger.kernel.org, git@vger.kernel.org
Subject: Re: Mercurial 0.3 vs git benchmarks
Message-ID: <20050427203917.GC12882@cip.informatik.uni-erlangen.de>
Mail-Followup-To: linux-kernel@vger.kernel.org, git@vger.kernel.org
References: <aec7e5c305042609231a5d3f0@mail.gmail.com> <20050426135606.7b21a2e2.akpm@osdl.org> <Pine.LNX.4.58.0504261405050.18901@ppc970.osdl.org> <20050426155609.06e3ddcf.akpm@osdl.org> <426ED20B.9070706@zytor.com> <871x8wb6w4.fsf@deneb.enyo.de> <20050427151357.GH1087@cip.informatik.uni-erlangen.de> <426FDFCD.6000309@zytor.com> <20050427190144.GA28848@cip.informatik.uni-erlangen.de> <426FF799.4000501@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <426FF799.4000501@zytor.com>
X-URL: http://wwwcip.informatik.uni-erlangen.de/~sithglan/
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

> Only if you read every single file in each directory every time.  I 
> thought mutt did header indexing and thus didn't need to do that.

it does, but it is a very recent development (coming with the next
release). Prior to this you need a patch, which has debian applied since
some time. And configure it. Otherwise *all* Maildir files we opened and
parsed when a folder is entered.

	Thomas
