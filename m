Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbWDRXQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbWDRXQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Apr 2006 19:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750799AbWDRXQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Apr 2006 19:16:59 -0400
Received: from web36613.mail.mud.yahoo.com ([209.191.85.30]:19072 "HELO
	web36613.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750824AbWDRXQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Apr 2006 19:16:58 -0400
Message-ID: <20060418231657.68869.qmail@web36613.mail.mud.yahoo.com>
X-RocketYMMF: rancidfat
Date: Tue, 18 Apr 2006 16:16:57 -0700 (PDT)
From: Casey Schaufler <casey@schaufler-ca.com>
Reply-To: casey@schaufler-ca.com
Subject: Re: [RESEND][RFC][PATCH 2/7] implementation of LSM hooks
To: James Morris <jmorris@namei.org>
Cc: linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org,
       fireflier-devel@lists.sourceforge.net
In-Reply-To: <Pine.LNX.4.64.0604181709160.28128@d.namei>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



--- James Morris <jmorris@namei.org> wrote:


> No.  The inode design is simply correct.

If this were true audit records would not be required
to contain path names. Names are important. To meet
EAL requirements path names are demonstrably
insufficient, but so too are inode numbers. Unless
you want to argue that Linux is unevaluateable
(a pretty tough position to defend) because it
requires both in an audit record you cannot claim
either is definitive.


Casey Schaufler
casey@schaufler-ca.com
