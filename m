Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVAJNoQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVAJNoQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jan 2005 08:44:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbVAJNoP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jan 2005 08:44:15 -0500
Received: from pils.us-lot.org ([212.67.207.13]:52230 "EHLO pils.us-lot.org")
	by vger.kernel.org with ESMTP id S262249AbVAJNoM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jan 2005 08:44:12 -0500
To: L A Walsh <lkml@tlinx.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Reviving the concept of a stable series
References: <200501031424.j03EOV2t029019@laptop11.inf.utfsm.cl>
	<41E07711.3040008@tlinx.org>
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Mon, 10 Jan 2005 13:44:08 +0000
In-Reply-To: <41E07711.3040008@tlinx.org> (L. A. Walsh's message of "Sat, 08
 Jan 2005 16:13:05 -0800")
Message-ID: <y2ais65z9ef.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

L A Walsh <lkml@tlinx.org> writes:

> If you have a better way of creating a stable series of kernels
> coming off kernel.org, I'm not attached to any specific method of
> "how".

One option would be a "Linux Legacy" project, similar to the Fedora
Legacy project that backports updates to old Red Hat/Fedora Core
releases: a central service that'd collect bug fixes for released
kernels that distributors could then base their kernels on. That way,
we'd get the stability advantages of vendor kernels without needing to
repeat the effort for each distribution.

Maybe some of the distribution vendors might be interested in setting
up something like this?

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
