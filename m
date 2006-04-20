Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750872AbWDTE33@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750872AbWDTE33 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 00:29:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751258AbWDTE33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 00:29:29 -0400
Received: from mail2.sea5.speakeasy.net ([69.17.117.4]:31693 "EHLO
	mail2.sea5.speakeasy.net") by vger.kernel.org with ESMTP
	id S1750872AbWDTE32 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 00:29:28 -0400
Date: Thu, 20 Apr 2006 00:29:24 -0400 (EDT)
From: James Morris <jmorris@namei.org>
X-X-Sender: jmorris@d.namei
To: Casey Schaufler <casey@schaufler-ca.com>
cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
In-Reply-To: <20060420041059.21278.qmail@web36608.mail.mud.yahoo.com>
Message-ID: <Pine.LNX.4.64.0604200024550.9722@d.namei>
References: <20060420041059.21278.qmail@web36608.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[dropped fireflier-devel]

On Wed, 19 Apr 2006, Casey Schaufler wrote:

> Just to be clear here, not everyone is comfortable with the idea of a 
> security "policy" that is developed, maintained, and stored 
> independently of the kernel and the applications to which it is applied.

This has never been required; it's just the way standard policy was 
developed historically.

The current trend is to move policy development to the packages being 
protected, made possible through the recent modular policy work by Tresys.  
Several developer tools are being developed to help support this.

(SELinux developments of note are posted at: http://selinuxnews.org/wp/ 
and in the various blogs linked there).



- James
-- 
James Morris
<jmorris@namei.org>
