Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269783AbUKASVj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269783AbUKASVj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Nov 2004 13:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268915AbUKARzp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Nov 2004 12:55:45 -0500
Received: from pfepb.post.tele.dk ([195.41.46.236]:2157 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S283410AbUKARxk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Nov 2004 12:53:40 -0500
Date: Mon, 1 Nov 2004 19:53:55 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Alexey Dobriyan <adobriyan@mail.ru>
Cc: sam@ravnborg.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] kernel-doc: print arrays in declarations correctly.
Message-ID: <20041101185355.GB24639@mars.ravnborg.org>
Mail-Followup-To: Alexey Dobriyan <adobriyan@mail.ru>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
References: <E1CONOf-00033G-00.adobriyan-mail-ru@f19.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CONOf-00033G-00.adobriyan-mail-ru@f19.mail.ru>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 01, 2004 at 12:37:57AM +0300, Alexey Dobriyan wrote:
> Do not convert arrays into pointers while generating documentation for them.
Applied

	Sam
