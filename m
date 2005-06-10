Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261332AbVFJWkj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261332AbVFJWkj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Jun 2005 18:40:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261319AbVFJWid
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Jun 2005 18:38:33 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:38369 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S261308AbVFJWiN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Jun 2005 18:38:13 -0400
Date: Fri, 10 Jun 2005 23:38:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: "Timothy R. Chavez" <tinytim@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
       David Woodhouse <dwmw2@infradead.org>, Steve Grubb <sgrubb@redhat.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@osdl.org>,
       Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
       Mounir Bsaibes <bsaibes@us.ibm.com>
Subject: Re: [RFC][PATCH] filesystem auditing by location+name
Message-ID: <20050610223806.GA16506@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Timothy R. Chavez" <tinytim@us.ibm.com>,
	linux-kernel@vger.kernel.org, Serge Hallyn <serue@us.ibm.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Steve Grubb <sgrubb@redhat.com>,
	Stephen Smalley <sds@tycho.nsa.gov>, Chris Wright <chrisw@osdl.org>,
	Alexander Viro <viro@parcelfarce.linux.theplanet.co.uk>,
	Mounir Bsaibes <bsaibes@us.ibm.com>
References: <200506101728.25709.tinytim@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200506101728.25709.tinytim@us.ibm.com>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

most of this looks like a copy & paste of the inotify code.  Could you
please arrange with the inotify folks to merge the patches?
