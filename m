Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269745AbUJMQRT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269745AbUJMQRT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Oct 2004 12:17:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269746AbUJMQRT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Oct 2004 12:17:19 -0400
Received: from rproxy.gmail.com ([64.233.170.194]:44199 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269745AbUJMQRR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Oct 2004 12:17:17 -0400
Message-ID: <9625752b041013091772e26739@mail.gmail.com>
Date: Wed, 13 Oct 2004 09:17:16 -0700
From: Danny <dannydaemonic@gmail.com>
Reply-To: Danny <dannydaemonic@gmail.com>
To: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: mm kernel oops with r8169 & named, PREEMPT
In-Reply-To: <9625752b04101309054eccbf@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
References: <9625752b041012230068619e68@mail.gmail.com>
	 <20041013072814.GA24066@electric-eye.fr.zoreil.com>
	 <9625752b04101309054eccbf@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I should mention that the oops (there was actually 3 of them not just
2) was without the patch suggested by Francois Romieu.  I assumed that
would be more useful as I still get the oops with it.  Let me know if
it would help and I'll repatch it and send another oops.
