Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750935AbWHPG1q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935AbWHPG1q (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 02:27:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750940AbWHPG1q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 02:27:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50154 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750905AbWHPG1p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 02:27:45 -0400
Date: Tue, 15 Aug 2006 23:27:18 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Shem Multinymous" <multinymous@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Robert Love" <rlove@rlove.org>,
       "Greg Kroah-Hartman" <gregkh@suse.de>,
       hdaps-devel@lists.sourceforge.net, "Pavel Machek" <pavel@suse.cz>,
       "Jean Delvare" <khali@linux-fr.org>
Subject: Re: [-mm patch] hdaps: Add explicit hardware configuration
 functions - fix
Message-Id: <20060815232718.d6a0ef03.akpm@osdl.org>
In-Reply-To: <41840b750608151526r19748630y75118a2f5032ca6@mail.gmail.com>
References: <41840b750608151526r19748630y75118a2f5032ca6@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 Aug 2006 01:26:07 +0300
"Shem Multinymous" <multinymous@gmail.com> wrote:

> Andrew, do you prefer to get the full rolled-up patch in such cases?

If practical, little fine-grained patches like this are much preferred, thanks.
