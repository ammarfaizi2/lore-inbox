Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932348AbWIZQcJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932348AbWIZQcJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Sep 2006 12:32:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932353AbWIZQcI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Sep 2006 12:32:08 -0400
Received: from smtp.osdl.org ([65.172.181.4]:44171 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932348AbWIZQcF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Sep 2006 12:32:05 -0400
Date: Tue, 26 Sep 2006 09:31:42 -0700
From: Andrew Morton <akpm@osdl.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Pavel Machek <pavel@suse.cz>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       alsa-devel@alsa-project.org
Subject: Re: 2.6.18: hda_intel: azx_get_response timeout, switching to
 single_cmd mode...
Message-Id: <20060926093142.43369b93.akpm@osdl.org>
In-Reply-To: <s5hlko7szjy.wl%tiwai@suse.de>
References: <451834D0.40304@goop.org>
	<s5hlko7szjy.wl%tiwai@suse.de>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Sep 2006 12:16:33 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> You must see difference with mm1 (suppose that mm1 already includes
> the latest ALSA patches).

No, the alsa tree was accidentally omitted from 2.6.18-mm1, sorry.
