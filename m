Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262153AbVBAWqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262153AbVBAWqH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 17:46:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262149AbVBAWow
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 17:44:52 -0500
Received: from fmr18.intel.com ([134.134.136.17]:28626 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S262153AbVBAWny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 17:43:54 -0500
Date: Tue, 1 Feb 2005 14:43:53 -0800
From: Mitch Williams <mitch.a.williams@intel.com>
X-X-Sender: mawilli1@mawilli1-desk2.amr.corp.intel.com
To: Greg KH <greg@kroah.com>
cc: "Williams, Mitch A" <mitch.a.williams@intel.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] change sematics of read flag
In-Reply-To: <20050201085653.GA23068@kroah.com>
Message-ID: <Pine.CYG.4.58.0502011441230.1672@mawilli1-desk2.amr.corp.intel.com>
References: <Pine.CYG.4.58.0501211452420.3364@mawilli1-desk2.amr.corp.intel.com>
 <20050201083800.GB22162@kroah.com> <20050201085653.GA23068@kroah.com>
ReplyTo: "Mitch Williams" <mitch.a.williams@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 1 Feb 2005, Greg KH wrote:

>
> Ick, no.  Pulled back out, as it doesn't even compile :(
>

Ick, indeed.  Yet another victim of my sneaky attempt to whack one large
patch up into three small patches.  Let's just forget this patch ever
existed, since it doesn't add any new functionality and probably shrinks
the running kernel by a good three bytes.

And I'll quit trying to be sneaky.

Thanks again for your help and patience on this stuff.

-Mitch
