Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266296AbVBEWGF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266296AbVBEWGF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 17:06:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265935AbVBEWGE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 17:06:04 -0500
Received: from c-24-15-231-36.client.comcast.net ([24.15.231.36]:19693 "EHLO
	topaz") by vger.kernel.org with ESMTP id S263942AbVBEWFx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 17:05:53 -0500
To: John M Flinchbaugh <john@hjsoft.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc3: intel8x0 alsa outputs no sound
References: <20050204213337.GA12347@butterfly.hjsoft.com>
From: Narayan Desai <desai@mcs.anl.gov>
Date: Sat, 05 Feb 2005 16:06:44 -0600
In-Reply-To: <20050204213337.GA12347@butterfly.hjsoft.com> (John M.
 Flinchbaugh's message of "Fri, 4 Feb 2005 16:33:37 -0500")
Message-ID: <874qgqu0ej.fsf@topaz.mcs.anl.gov>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try muting the headphone jack sense control with alsamixer. I had the
same problem with rc2 on my t41p, and that solved it.
 -nld
