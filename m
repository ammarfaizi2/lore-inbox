Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751301AbWDTE5A@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751301AbWDTE5A (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 00:57:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751292AbWDTE5A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 00:57:00 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:31105 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1751282AbWDTE47
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 00:56:59 -0400
Date: Wed, 19 Apr 2006 21:56:59 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
Message-ID: <20060420045659.GS4917@sorel.sous-sol.org>
References: <20060420041059.21278.qmail@web36608.mail.mud.yahoo.com> <Pine.LNX.4.64.0604200024550.9722@d.namei>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604200024550.9722@d.namei>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* James Morris (jmorris@namei.org) wrote:
> The current trend is to move policy development to the packages being 
> protected, made possible through the recent modular policy work by Tresys.  
> Several developer tools are being developed to help support this.

I agree, this is the sanest model.  Ideally it could be expressed in
some form directly from app developers...I can dream ;-)

thanks,
-chris
