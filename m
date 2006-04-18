Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932302AbWDRUAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932302AbWDRUAK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 16:00:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932305AbWDRUAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 16:00:10 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:30891 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S932302AbWDRUAI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 16:00:08 -0400
Date: Tue, 18 Apr 2006 14:59:56 -0500
From: "Serge E. Hallyn" <serue@us.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Gerrit Huizenga <gh@us.ibm.com>, Christoph Hellwig <hch@infradead.org>,
       James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060418195956.GH29302@sergelap.austin.ibm.com>
References: <E1FVtPV-0005zu-00@w-gerrit.beaverton.ibm.com> <1145386009.21723.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1145386009.21723.27.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Alan Cox (alan@lxorguk.ukuu.org.uk):
> On Maw, 2006-04-18 at 09:50 -0700, Gerrit Huizenga wrote:
> > or are there places where a "less than perfect, easy to use, good enough"
> > security policy?  I believe there is room for both based on the end
> > users' needs and desires.  But that is just my opinion.
> 
> Poor security systems lead to less security than no security because it
> lulls people into a false sense of security. Someone who knows their

Not wanting to make any digs one way or another, but because the culture
right now refuses to admit it I must point out:

So does "security" which is too complicated and therefore ends up
misconfigured (or disabled).

The posix caps sendmail fiasco is one example.

-serge
