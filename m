Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751374AbWDQWzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751374AbWDQWzb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751376AbWDQWzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:55:31 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:56986 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S1751374AbWDQWza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:55:30 -0400
Date: Mon, 17 Apr 2006 23:55:25 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060417225525.GA17463@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Gerrit Huizenga <gh@us.ibm.com>, James Morris <jmorris@namei.org>,
	"Serge E. Hallyn" <serue@us.ibm.com>,
	Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
	fireflier-devel@lists.sourceforge.net
References: <Pine.LNX.4.64.0604171528340.17923@d.namei> <E1FVc0H-00077d-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FVc0H-00077d-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 17, 2006 at 03:15:29PM -0700, Gerrit Huizenga wrote:
> configure correctly that most of them disable it.  In theory, LSM +
> something like AppArmour provides a much simpler security model for

apparmor falls into the findamentally broken category above, so it's
totally uninteresting except as marketing candy for the big red company.

