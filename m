Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbUKQPzi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbUKQPzi (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 10:55:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262352AbUKQPzW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 10:55:22 -0500
Received: from host62-24-231-113.dsl.vispa.com ([62.24.231.113]:1421 "EHLO
	cenedra.walrond.org") by vger.kernel.org with ESMTP id S262353AbUKQPyt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 10:54:49 -0500
From: Andrew Walrond <andrew@walrond.org>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.6.10-rc2
Date: Wed, 17 Nov 2004 15:54:32 +0000
User-Agent: KMail/1.7
Cc: Linus Torvalds <torvalds@osdl.org>,
       linux-fbdev-devel@lists.sourceforge.net
References: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0411141835150.2222@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200411171554.32382.andrew@walrond.org>
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 15 Nov 2004 02:49, Linus Torvalds wrote:
>
> Antonino Daplas:
...
>   o fbdev: Fix IO access in rivafb

FYI

changeset 1.2563 breaks the rivafb for x86_64 (64bit). I'm looking into it 
with the fbdev guys help, so I'm sure a fix will be forthcoming soon.

Andrew Walrond
