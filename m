Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262262AbVC2NUa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262262AbVC2NUa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Mar 2005 08:20:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262288AbVC2NUa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Mar 2005 08:20:30 -0500
Received: from mail1.upco.es ([130.206.70.227]:60106 "EHLO mail1.upco.es")
	by vger.kernel.org with ESMTP id S262262AbVC2NUZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Mar 2005 08:20:25 -0500
Date: Tue, 29 Mar 2005 15:20:22 +0200
From: Romano Giannetti <romanol@upco.es>
To: linux-kernel@vger.kernel.org
Cc: Andrew Morton <akpm@osdl.org>, Pavel Machek <pavel@ucw.cz>
Subject: Re: swsusp not working for me on a PREEMPT 2.6.12-rc1 and 2.6.12-rc1-mm3 kernel
Message-ID: <20050329132022.GA26553@pern.dea.icai.upco.es>
Reply-To: romano@dea.icai.upco.es
Mail-Followup-To: romano@dea.icai.upco.es,
	linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
	Pavel Machek <pavel@ucw.cz>
References: <20050329110309.GA17744@pern.dea.icai.upco.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20050329110309.GA17744@pern.dea.icai.upco.es>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 29, 2005 at 01:03:09PM +0200, Romano Giannetti wrote:
> Hi all,
> 
>    swsusp is not working for me with 2.6.12rc1. I compiled the kernel
>    preempt, I am compiling now without preempt to test it. -mm3 has a
>    similar behaviour.

Tested with no-preempt -rc1-mm3. No joy; the suspend stops exactly at the
same point. 

If you need more info, just tell me. 

Romano 

-- 
Romano Giannetti             -  Univ. Pontificia Comillas (Madrid, Spain)
Electronic Engineer - phone +34 915 422 800 ext 2416  fax +34 915 596 569
