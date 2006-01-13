Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030325AbWAMJBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030325AbWAMJBi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 04:01:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030321AbWAMJBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 04:01:38 -0500
Received: from mx1.redhat.com ([66.187.233.31]:63114 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1030325AbWAMJBh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 04:01:37 -0500
Date: Fri, 13 Jan 2006 04:00:32 -0500
From: Alan Cox <alan@redhat.com>
To: Chris Wright <chrisw@sous-sol.org>
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       torvalds@osdl.org, akpm@osdl.org, alan@lxorguk.ukuu.org.uk,
       Alan Cox <alan@redhat.com>
Subject: Re: [PATCH 15/17] [PATCH] moxa serial: add proper capability check
Message-ID: <20060113090032.GA3265@devserv.devel.redhat.com>
References: <20060113032102.154909000@sorel.sous-sol.org> <20060113032248.205414000@sorel.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060113032248.205414000@sorel.sous-sol.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2006 at 06:37:53PM -0800, Chris Wright wrote:
> -stable review patch.  If anyone has any objections, please let us know.
> ------------------
> 
> This requires the proper capabilities for the moxa bios update ioctl's.
> 
> Signed-off-by: Linus Torvalds <torvalds@osdl.org>
> Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Alan Cox <alan@redhat.com>
