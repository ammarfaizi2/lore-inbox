Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264377AbUFSQRQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264377AbUFSQRQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 12:17:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbUFSQQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 12:16:33 -0400
Received: from pfepc.post.tele.dk ([195.41.46.237]:1164 "EHLO
	pfepc.post.tele.dk") by vger.kernel.org with ESMTP id S264297AbUFSQM5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 12:12:57 -0400
Subject: Re: RSA
From: Kristian =?ISO-8859-1?Q?S=F8rensen?= <ks@cs.auc.dk>
To: Joy Latten <latten@austin.ibm.com>
Cc: linux-kernel@vger.kernel.org, sergeh@us.ibm.com,
       The Umbrella Team <umbrella@cs.auc.dk>
In-Reply-To: <200406150944.i5F9ixec013290@faith.austin.ibm.com>
References: <200406150944.i5F9ixec013290@faith.austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-15
Message-Id: <1087661573.31745.52.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Sat, 19 Jun 2004 18:12:53 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

The Umbrella project (umbrella.sf.net) also needs the ability to use
public key cryptography within the Linux kernel (though only to verify
signatures).

We were planing to implement RSA or ElGamal (porting some of GPG) to the
kernel for that purpose. However, if this project gets started, we will
be very interested. In the automn we might also have some development
hours to contribute with :-)

Cheers, KS.

On Tue, 2004-06-15 at 11:44, Joy Latten wrote:
> Is anyone working on implementing RSA encryption/decryption into the
> kernel's cryptoapi? If not, I was considering starting such a project.
> 
> Regards,
> Joy Latten
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
-- 
Kristian Sørensen <ks@cs.auc.dk>

