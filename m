Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262770AbTIVEju (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 00:39:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262772AbTIVEju
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 00:39:50 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:4367
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S262770AbTIVEjt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 00:39:49 -0400
Subject: Re: [ANNOUNCE]  slab information utility
From: Robert Love <rml@tech9.net>
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Chris Rivera <cmrivera@ufl.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <20030922042308.GA8691@DUK2.13thfloor.at>
References: <1064199786.1199.29.camel@boobies.awol.org>
	 <20030922042308.GA8691@DUK2.13thfloor.at>
Content-Type: text/plain
Message-Id: <1064205590.8888.207.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 (1.4.4-7) 
Date: Mon, 22 Sep 2003 00:39:50 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-09-22 at 00:23, Herbert Poetzl wrote:

> dm io                  0      0     36    0    0    1 :      0       0     0    0    0 :  252  126 :      0      0      0      0

It is this bastard.  No easy way to parse text files when fields have
the delimiter in them, unfortunately.

Not too sure what to do but patch the kernel not to have spaces in slab
cache names.  I know I have seen such patches go in before.

	Robert Love


