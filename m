Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264353AbTH1XaN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 19:30:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264423AbTH1XaN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 19:30:13 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41701 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S264353AbTH1XaL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 19:30:11 -0400
Date: Thu, 28 Aug 2003 16:21:29 -0700
From: "David S. Miller" <davem@redhat.com>
To: Patrick McHardy <kaber@trash.net>
Cc: marcelo@conectiva.com.br, Robert.L.Harris@rdlg.net,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-bk2 and 2.4.23-pre1 broke routing
Message-Id: <20030828162129.37142d52.davem@redhat.com>
In-Reply-To: <3F4E2772.8050104@trash.net>
References: <Pine.LNX.4.55L.0308281134120.9167@freak.distro.conectiva>
	<3F4E2772.8050104@trash.net>
X-Mailer: Sylpheed version 0.9.2 (GTK+ 1.2.6; sparc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Aug 2003 18:01:54 +0200
Patrick McHardy <kaber@trash.net> wrote:

> It's fixed by this patch. (tested by Hans Lambrechts).

Please submit this fix to the netfilter maintainers, I'd
like them to review the change and submit it to me.
