Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268081AbUIFOpA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268081AbUIFOpA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Sep 2004 10:45:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268084AbUIFOpA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Sep 2004 10:45:00 -0400
Received: from mail1.kontent.de ([81.88.34.36]:52168 "EHLO Mail1.KONTENT.De")
	by vger.kernel.org with ESMTP id S268081AbUIFOoo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Sep 2004 10:44:44 -0400
From: Oliver Neukum <oliver@neukum.org>
To: Gunnar Ritter <Gunnar.Ritter@pluto.uni-freiburg.de>
Subject: Re: [PATCH 1/3] copyfile: generic_sendpage
Date: Mon, 6 Sep 2004 16:46:41 +0200
User-Agent: KMail/1.6.2
Cc: =?iso-8859-15?q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
References: <20040904165733.GC8579@wohnheim.fh-wedel.de> <20040906133523.GC25429@wohnheim.fh-wedel.de> <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de>
In-Reply-To: <413C74E6.nail3YF11Y0TT@pluto.uni-freiburg.de>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Message-Id: <200409061646.41772.oliver@neukum.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 6. September 2004 16:32 schrieb Gunnar Ritter:
> Then I don't see the point in having a copyfile system call. In

Potentially tremendous speedups in networked filesystems.

	Regards
		Oliver
