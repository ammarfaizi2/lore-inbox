Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267538AbSKSXGZ>; Tue, 19 Nov 2002 18:06:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267550AbSKSXGZ>; Tue, 19 Nov 2002 18:06:25 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:60173
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267538AbSKSXGY>; Tue, 19 Nov 2002 18:06:24 -0500
Subject: Re: [TRIVIAL PATCH 2.5.48] Fixed ifdefs for a label in ncpfs/sock.c
From: Robert Love <rml@tech9.net>
To: Dave Jones <davej@codemonkey.org.uk>
Cc: Bob Miller <rem@osdl.org>, trivial@rustcorp.com.au,
       linux-kernel@vger.kernel.org
In-Reply-To: <20021119190217.GA8317@suse.de>
References: <20021119185236.GI1986@doc.pdx.osdl.net>
	 <20021119190217.GA8317@suse.de>
Content-Type: text/plain
Organization: 
Message-Id: <1037747606.1253.2265.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.0 
Date: 19 Nov 2002 18:13:26 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2002-11-19 at 14:02, Dave Jones wrote:

> Eww, personally I think the fix is worse than the warning.

Yah that is ugly, but I personally think we should strive to eliminate
warnings.  One day this really may be an unused label.

I am not sure how else to cleanly get rid of this.

	Robert Love

