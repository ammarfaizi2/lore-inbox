Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263500AbTKKN6U (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Nov 2003 08:58:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263504AbTKKN6U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Nov 2003 08:58:20 -0500
Received: from pentafluge.infradead.org ([213.86.99.235]:46983 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S263500AbTKKN6T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Nov 2003 08:58:19 -0500
Subject: Re: OT: why no file copy() libc/syscall ??
From: David Woodhouse <dwmw2@infradead.org>
To: Jakub Jelinek <jakub@redhat.com>
Cc: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
       Albert Cahalan <albert@users.sourceforge.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>,
       davide.rossetti@roma1.infn.it, filia@softhome.net,
       jesse@cats-chateau.net, moje@vabo.cz, kakadu_croc@yahoo.com
In-Reply-To: <20031111085323.M8854@devserv.devel.redhat.com>
References: <1068512710.722.161.camel@cube>
	 <20031111133859.GA11115@bitwizard.nl>
	 <20031111085323.M8854@devserv.devel.redhat.com>
Content-Type: text/plain
Message-Id: <1068559093.5855.10.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-8.dwmw2.1) 
Date: Tue, 11 Nov 2003 13:58:14 +0000
Content-Transfer-Encoding: 7bit
X-SA-Exim-Mail-From: dwmw2@infradead.org
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
X-Pentafluge-Mail-From: <dwmw2@infradead.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-11-11 at 08:53 -0500, Jakub Jelinek wrote:
> But e.g. the CIFS copy can be done as sendfile hook.

Can it? I thought it took filenames.

-- 
dwmw2

