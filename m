Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261747AbTDHUY7 (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 16:24:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTDHUY7 (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 16:24:59 -0400
Received: from magic-mail.adaptec.com ([208.236.45.100]:40875 "EHLO
	magic.adaptec.com") by vger.kernel.org with ESMTP id S261747AbTDHUY7 (for <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Apr 2003 16:24:59 -0400
Date: Tue, 08 Apr 2003 14:36:19 -0600
From: "Justin T. Gibbs" <gibbs@scsiguy.com>
Reply-To: "Justin T. Gibbs" <gibbs@scsiguy.com>
To: Robert Schiele <rschiele@uni-mannheim.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] aic7* claims all checked EISA io ranges (was: [MAILER-DAEMON@rumms.uni-mannheim.de: Returned mail: see transcript for details])
Message-ID: <3566580000.1049834178@aslan.btc.adaptec.com>
In-Reply-To: <20030408071845.GA10002@schiele.local>
References: <20030408071845.GA10002@schiele.local>
X-Mailer: Mulberry/3.0.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hello.
> 
> Some days ago a bug was introduced in aic7xxx by applying the aic7xxx driver
> upgrade to both the 2.4 and the 2.5 tree.

This particular defect was corrected in all versions of the aic7xxx
driver released by me after March 9th.  See the driver CHANGELOG in
the driver source distribution for details.

http://people.FreeBSD.org/~gibbs/linux/SRC/

--
Justin

