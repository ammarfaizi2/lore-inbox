Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265234AbVBDXrM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265234AbVBDXrM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 18:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263502AbVBDXrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 18:47:09 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21979 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266290AbVBDXpR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 18:45:17 -0500
Subject: Re: [Ext2-devel] [PATCH] JBD: journal_release_buffer()
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Alex Tomas <alex@clusterfs.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "ext2-devel@lists.sourceforge.net" <ext2-devel@lists.sourceforge.net>,
       Andrew Morton <akpm@osdl.org>, Stephen Tweedie <sct@redhat.com>
In-Reply-To: <m3vf9ffaoj.fsf@bzzz.home.net>
References: <m3wtu9v3il.fsf@bzzz.home.net>
	 <1106604342.2103.395.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3brbebh43.fsf@bzzz.home.net>
	 <1106609725.2103.616.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3sm4p8tk7.fsf@bzzz.home.net>
	 <1106670089.1985.766.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3k6q18fwt.fsf@bzzz.home.net>
	 <1106759535.1953.53.camel@sisko.sctweedie.blueyonder.co.uk>
	 <m3vf9ffaoj.fsf@bzzz.home.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1107560699.4075.167.camel@sisko.sctweedie.blueyonder.co.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date: Fri, 04 Feb 2005 23:45:00 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, 2005-01-30 at 10:55, Alex Tomas wrote:

> yup, you're right. so, here is an implementation of this.
> tested on UP/SMP by dbench/fsx. Stephen, Andrew, could you
> review the patch and give it a run? 

Just to say I haven't forgotten, just been battling this week against
all sorts of apparent hardware problems on some test boxes... I'll try
to get you some proper results next week.

Cheers,
 Stephen

