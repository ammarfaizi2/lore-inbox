Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262621AbTJJNa3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Oct 2003 09:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262570AbTJJNa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Oct 2003 09:30:29 -0400
Received: from yakov.inr.ac.ru ([193.233.7.111]:5809 "HELO yakov.inr.ac.ru")
	by vger.kernel.org with SMTP id S262066AbTJJNaZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Oct 2003 09:30:25 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200310101329.RAA16404@yakov.inr.ac.ru>
Subject: Re: patch to implement RFC3517 in linux 2.4.22
To: davem@redhat.com (David S. Miller)
Date: Fri, 10 Oct 2003 17:29:46 +0400 (MSD)
Cc: doug@eee.strath.ac.uk, linux-net@vger.kernel.org,
       linux-kernel@vger.kernel.org, kuznet@ms2.inr.ac.ru,
       jmorris@intercode.com.au, yoshfuji@linux-ipv6.org
In-Reply-To: <20031010012759.3e5e400f.davem@redhat.com> from "David S. Miller" at Oct 10, 2003 01:27:59 AM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Alexey, comments?

I do not understand the patch. I suppose it _is_ current behaviour,
the corresponding places are "commented out" with IsReno() predicate.

Shortly, I cannot figure out even what the patch is expected to change.

Alexey
