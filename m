Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751194AbVLOW6T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751194AbVLOW6T (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 17:58:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751192AbVLOW6T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 17:58:19 -0500
Received: from khc.piap.pl ([195.187.100.11]:17412 "EHLO khc.piap.pl")
	by vger.kernel.org with ESMTP id S1751194AbVLOW6R (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 17:58:17 -0500
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: agpgart.ko can't be unloaded
References: <m3acf2i05d.fsf@defiant.localdomain>
	<20051215205221.GG19354@redhat.com>
From: Krzysztof Halasa <khc@pm.waw.pl>
Date: Thu, 15 Dec 2005 23:58:16 +0100
In-Reply-To: <20051215205221.GG19354@redhat.com> (Dave Jones's message of
 "Thu, 15 Dec 2005 15:52:21 -0500")
Message-ID: <m3lkymge7r.fsf@defiant.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:

> the reference on the chipset driver should only be bumped when
> /dev/agpgart is open()'d, but currently that isn't the case.

Ok. I will look at it then.
-- 
Krzysztof Halasa
