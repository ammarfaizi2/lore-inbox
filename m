Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267313AbUHSTqH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267313AbUHSTqH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 15:46:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267345AbUHSTqG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 15:46:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:19405 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S267313AbUHSTpg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 15:45:36 -0400
Date: Thu, 19 Aug 2004 12:42:11 -0700
From: "David S. Miller" <davem@redhat.com>
To: jmerkey@comcast.net
Cc: root@chaos.analogic.com, linux-kernel@vger.kernel.org, jmerkey@drdos.com
Subject: Re: kallsyms 2.6.8 address ordering
Message-Id: <20040819124211.2e4d57e4.davem@redhat.com>
In-Reply-To: <081920041927.27479.4124FF1B00008D3A00006B572200751150970A059D0A0306@comcast.net>
References: <081920041927.27479.4124FF1B00008D3A00006B572200751150970A059D0A0306@comcast.net>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 19 Aug 2004 19:27:23 +0000
jmerkey@comcast.net wrote:

> jmerkey@drdos.com is blocked from posting to this list.  I have verified it though smtp, so I use 
> my comcast.net account instead.  David Miller **WONT** respond to emails or the other list 
> maintainers.  

Well, you're not in the by-hand SPAM filter, so it must be something else.

? egrep drdos /opt/mail/db/smtp-policy.spam.manual
? egrep jmerkey /opt/mail/db/smtp-policy.spam.manual

What message do you get back from direct smtp tests?
