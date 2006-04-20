Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750878AbWDTXF6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750878AbWDTXF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 19:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWDTXF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 19:05:58 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:27881 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1750861AbWDTXF5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 19:05:57 -0400
Date: Fri, 21 Apr 2006 00:05:51 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Linda A. Walsh" <law@tlinx.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>, "Serge E. Hallyn" <serue@us.ibm.com>,
       linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
       linux-kernel@vger.kernel.org, Tony Jones <tonyj@suse.de>
Subject: Re: [RFC][PATCH 11/11] security: AppArmor - Export namespace	semaphore
Message-ID: <20060420230551.GA5026@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Linda A. Walsh" <law@tlinx.org>,
	Stephen Smalley <sds@tycho.nsa.gov>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	linux-security-module@vger.kernel.org, chrisw@sous-sol.org,
	linux-kernel@vger.kernel.org, Tony Jones <tonyj@suse.de>
References: <20060419174905.29149.67649.sendpatchset@ermintrude.int.wirex.com> <20060419175034.29149.94306.sendpatchset@ermintrude.int.wirex.com> <1145536742.16456.35.camel@moss-spartans.epoch.ncsc.mil> <20060420124647.GD18604@sergelap.austin.ibm.com> <1145534735.3313.3.camel@moss-spartans.epoch.ncsc.mil> <20060420132128.GG18604@sergelap.austin.ibm.com> <1145537318.3313.40.camel@moss-spartans.epoch.ncsc.mil> <44480727.9010500@tlinx.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44480727.9010500@tlinx.org>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2006 at 03:11:51PM -0700, Linda A. Walsh wrote:
>    The *current* accepted way to get pathnames going into system
> calls is to trap the syscall vector as audit currently does --

It's not and it's never been.  Please get a fucking clue instead of
posting your uninformed opinions to lkml.

