Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285079AbRLFJiF>; Thu, 6 Dec 2001 04:38:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285078AbRLFJhp>; Thu, 6 Dec 2001 04:37:45 -0500
Received: from t2.redhat.com ([199.183.24.243]:62457 "EHLO
	passion.cambridge.redhat.com") by vger.kernel.org with ESMTP
	id <S285077AbRLFJhk>; Thu, 6 Dec 2001 04:37:40 -0500
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
From: David Woodhouse <dwmw2@infradead.org>
X-Accept-Language: en_GB
In-Reply-To: <20011206091418.4d031a5c.lkml@andyjeffries.co.uk> 
In-Reply-To: <20011206091418.4d031a5c.lkml@andyjeffries.co.uk> 
To: Andy Jeffries <lkml@andyjeffries.co.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: SMTP->Windows connection with 2.4.16 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 06 Dec 2001 09:37:22 +0000
Message-ID: <15058.1007631442@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


lkml@andyjeffries.co.uk said:
> A friend of mine is having a problem connecting to Blueyonder's SMTP
> server with a 2.4.16 Kernel.

Their firewall is broken. See http://gtf.org/garzik/ecn/ but note that it's
fairly out of date - ECN actually became a Proposed Standard months ago, and
for Blueyonder to _still_ be running a broken firewall is a particularly
spectacular display of incompetence.

--
dwmw2


