Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVCMI4D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVCMI4D (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 03:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbVCMI4D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 03:56:03 -0500
Received: from pfepa.post.tele.dk ([195.41.46.235]:12146 "EHLO
	pfepa.post.tele.dk") by vger.kernel.org with ESMTP id S261239AbVCMIz4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 03:55:56 -0500
Date: Sun, 13 Mar 2005 09:57:18 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: "George G. Davis" <gdavis@mvista.com>, trini@kernel.crashing.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Fix scripts/mkuboot.sh to return status
Message-ID: <20050313085718.GB24006@mars.ravnborg.org>
Mail-Followup-To: "George G. Davis" <gdavis@mvista.com>,
	trini@kernel.crashing.org, linux-kernel@vger.kernel.org
References: <20050303211640.GB20870@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050303211640.GB20870@mvista.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2005 at 04:16:41PM -0500, George G. Davis wrote:
> Sam,
> 
> If `mkimage` is either not found in search path or returns non-zero status,
> `make uImage` succeeds when it should fail. This changes scripts/mkuboot.sh
> to return status so build succeeds or fails as appropriate.


As per mail from Tom Roni I dropped this patch.

	Sam
