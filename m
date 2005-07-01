Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262399AbVGAUui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262399AbVGAUui (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 16:50:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262332AbVGAUuh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 16:50:37 -0400
Received: from postel.suug.ch ([195.134.158.23]:55020 "EHLO postel.suug.ch")
	by vger.kernel.org with ESMTP id S262399AbVGAUqR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 16:46:17 -0400
Date: Fri, 1 Jul 2005 22:46:37 +0200
From: Thomas Graf <tgraf@suug.ch>
To: Patrick McHardy <kaber@trash.net>
Cc: Patrick Jenkins <patjenk@wam.umd.edu>, linux-kernel@vger.kernel.org,
       Maillist netdev <netdev@oss.sgi.com>
Subject: Re: [PATCH] multipath routing algorithm, better patch
Message-ID: <20050701204637.GX16076@postel.suug.ch>
References: <Pine.GSO.4.61.0506302014160.7400@rac1.wam.umd.edu> <42C4919A.5000009@trash.net> <20050701174117.GW16076@postel.suug.ch> <42C59ABA.1070305@trash.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <42C59ABA.1070305@trash.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Patrick McHardy <42C59ABA.1070305@trash.net> 2005-07-01 21:34
> So its no problem but simply missing support. BTW, do you know if
> Stephen's new CVS repository is exported somewhere?

cvs -d :pserver:cvsanon@developer.osdl.org/repos cvs login
cvs -d :pserver:cvsanon@developer.osdl.org/repos cvs co iproute2
