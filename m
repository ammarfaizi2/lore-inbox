Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262509AbUKDXww@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262509AbUKDXww (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Nov 2004 18:52:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262508AbUKDXwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Nov 2004 18:52:32 -0500
Received: from mx1.redhat.com ([66.187.233.31]:59811 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262506AbUKDXwC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Nov 2004 18:52:02 -0500
Date: Thu, 4 Nov 2004 18:51:32 -0500 (EST)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@thoron.boston.redhat.com
To: Andrew Morton <akpm@osdl.org>, Serge Hallyn <serue@us.ibm.com>
cc: Chris Wright <chrisw@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
       Stephen Smalley <sds@epoch.ncsc.mil>
Subject: Re: [RFC] [PATCH] [0/6] LSM Stacking
In-Reply-To: <1099609471.2096.10.camel@serge.austin.ibm.com>
Message-ID: <Xine.LNX.4.44.0411041845040.20925-100000@thoron.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This code has not been ratified on the LSM list, there are still several
open issues, including opposition to the idea of arbitrary stacking of
security modules by myself.

I don't think that the kernel should provide such a service.

This is the initial LSM thread:
http://mail.wirex.com/pipermail/linux-security-module/2004-October/5567.html

Here are posts where I explain my objections:

http://mail.wirex.com/pipermail/linux-security-module/2004-October/5582.html
http://mail.wirex.com/pipermail/linux-security-module/2004-October/5584.html
http://mail.wirex.com/pipermail/linux-security-module/2004-October/5602.html

Please don't apply.


- James
-- 
James Morris
<jmorris@redhat.com>



