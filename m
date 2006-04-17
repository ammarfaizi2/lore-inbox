Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751274AbWDQW6b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751274AbWDQW6b (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Apr 2006 18:58:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751380AbWDQW6b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Apr 2006 18:58:31 -0400
Received: from mail4.sea5.speakeasy.net ([69.17.117.6]:8108 "EHLO
	mail4.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1751274AbWDQW6a (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Apr 2006 18:58:30 -0400
Date: Mon, 17 Apr 2006 18:58:26 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Gerrit Huizenga <gh@us.ibm.com>, "Serge E. Hallyn" <serue@us.ibm.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, casey@schaufler-ca.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
In-Reply-To: <1145314085.14793.35.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0604171857110.19479@d.namei>
References: <E1FVc0H-00077d-00@w-gerrit.beaverton.ibm.com>
 <1145314085.14793.35.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2006, Alan Cox wrote:

> > something like AppArmour provides a much simpler security model for
> 
> If the AppArmour people care to submit their code upstream and get it
> merged then that would be a reason to keep LSM, if they don't then LSM
> (if they even want it..) can just become part of their patchkit instead.

This is the discussion we had a year ago, and have seen nothing 
upstream since.  I assume they do not intend to submit the code.



- James
-- 
James Morris
<jmorris@namei.org>
