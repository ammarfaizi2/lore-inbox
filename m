Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262387AbVG2F6Y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262387AbVG2F6Y (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 01:58:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262416AbVG2F6Y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 01:58:24 -0400
Received: from dvhart.com ([64.146.134.43]:15290 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S262392AbVG2F6X (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 01:58:23 -0400
Date: Thu, 28 Jul 2005 22:58:29 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc3-mm3
Message-ID: <159600000.1122616708@[10.10.2.4]>
In-Reply-To: <20050728025840.0596b9cb.akpm@osdl.org>
References: <20050728025840.0596b9cb.akpm@osdl.org>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> - There's a pretty large x86_64 update here which naughty maintainer wants
>   in 2.6.13.  Extra testing, please.

Is still regressed as of 2.6.12 for me, at least. Crashes in TSC sync.
Talked to Andi about it at OLS, but then drank too much to remember the
conclusion ... however, it's still broken ;-)

Matrix is here (see left hand column).

http://test.kernel.org/

Example boot log is here:

http://test.kernel.org/9447/debug/console.log
