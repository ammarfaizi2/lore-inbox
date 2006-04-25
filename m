Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWDYO2f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWDYO2f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Apr 2006 10:28:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932236AbWDYO2e
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Apr 2006 10:28:34 -0400
Received: from THUNK.ORG ([69.25.196.29]:17314 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S932232AbWDYO2d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Apr 2006 10:28:33 -0400
Date: Tue, 25 Apr 2006 08:46:09 -0400
From: "Theodore Ts'o" <tytso@mit.edu>
To: James Morris <jmorris@namei.org>
Cc: Casey Schaufler <casey@schaufler-ca.com>,
       Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
       linux-security-module@vger.kernel.org
Subject: Re: [RFC][PATCH 0/11] security: AppArmor - Overview
Message-ID: <20060425124609.GA10113@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	James Morris <jmorris@namei.org>,
	Casey Schaufler <casey@schaufler-ca.com>,
	Stephen Smalley <sds@tycho.nsa.gov>, linux-kernel@vger.kernel.org,
	linux-security-module@vger.kernel.org
References: <20060425042542.53414.qmail@web36603.mail.mud.yahoo.com> <Pine.LNX.4.64.0604250254520.15998@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0604250254520.15998@d.namei>
User-Agent: Mutt/1.5.11+cvs20060126
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 25, 2006 at 03:50:00AM -0400, James Morris wrote:
> To make a rough analogy (as Ted mentioned his IETF work earlier...): 
> 
> The fundamental mechanisms of IPsec are sound.  It has taken many, many 
> years to get it to this stage, despite claims of it being "too 
> complicated".  In that time, several "simple" protocols were designed and 
> implemented to address the "complexity" issues, but it turns out, after 
> all, that with the right level of abstraction and tools, IPsec is not too 
> complicated to be secure or to use: by the obvious example of both its 
> widespread adoption and, afaik, no systemic security failures.

And yet, many people use SSH and TLS, and it is more than sufficient
for their needs.  Despite being very involved with the development of
IPSec, and Kerberos, there are plenty of times when I will tell people
to *not* use those technologies because they are *just* *too*
*complicated*.

Choice is good.

SELinux should not be the only way to do things.

						- Ted
