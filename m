Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262706AbTEFMVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 May 2003 08:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262700AbTEFMVq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 May 2003 08:21:46 -0400
Received: from pizda.ninka.net ([216.101.162.242]:36583 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id S262707AbTEFMVm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 May 2003 08:21:42 -0400
Date: Tue, 06 May 2003 04:26:44 -0700 (PDT)
Message-Id: <20030506.042644.82113400.davem@redhat.com>
To: rob@mur.org.uk
Cc: linux-kernel@vger.kernel.org
Subject: Re: failed assertions in 2.4.20 networking code
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20030506123142.GI2388@mur.org.uk>
References: <20030506112512.GH2388@mur.org.uk>
	<1052222662.983.29.camel@rth.ninka.net>
	<20030506123142.GI2388@mur.org.uk>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Robert Murray <rob@mur.org.uk>
   Date: Tue, 6 May 2003 13:31:42 +0100

   Thanks for the quick responce.  is this bug likely to cause any
   problems? I havn't noticed anything.

It could hang the server in question.
