Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262812AbVFWW2I@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262812AbVFWW2I (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Jun 2005 18:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbVFWW2H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Jun 2005 18:28:07 -0400
Received: from opersys.com ([64.40.108.71]:36874 "EHLO www.opersys.com")
	by vger.kernel.org with ESMTP id S262834AbVFWW1m (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Jun 2005 18:27:42 -0400
Message-ID: <42BB39EA.5080109@opersys.com>
Date: Thu, 23 Jun 2005 18:38:34 -0400
From: Karim Yaghmour <karim@opersys.com>
Reply-To: karim@opersys.com
Organization: Opersys inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.2) Gecko/20040805 Netscape/7.2
X-Accept-Language: en-us, en, fr, fr-be, fr-ca, fr-fr
MIME-Version: 1.0
To: Christian Hesse <mail@earthworm.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kernel .patches support
References: <200506232358.34897.mail@earthworm.de>
In-Reply-To: <200506232358.34897.mail@earthworm.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Christian Hesse wrote:
> every time I apply a patch to my kernel tree I (or my scripts) make an
> 
> echo $PATCHNAME $PATCHVERSION >> .patches
> 
> This patch makes the file accessible via /proc/patches.gz. I think this can be 
> handy if you want to know what patches you (or your distributor) applied to 
> your running kernel...

I haven't looked at the implementation, but I love the functionality.

Karim
-- 
Author, Speaker, Developer, Consultant
Pushing Embedded and Real-Time Linux Systems Beyond the Limits
http://www.opersys.com || karim@opersys.com || 1-866-677-4546
