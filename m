Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262820AbUJ1HRO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262820AbUJ1HRO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Oct 2004 03:17:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262819AbUJ1HRM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Oct 2004 03:17:12 -0400
Received: from smtp.istop.com ([66.11.167.126]:51856 "EHLO smtp.istop.com")
	by vger.kernel.org with ESMTP id S262826AbUJ1HP5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Oct 2004 03:15:57 -0400
From: Daniel Phillips <phillips@istop.com>
To: Michael Clark <michael@metaparadigm.com>
Subject: Re: 2.6.9 page allocation failure. order:0, mode:0x20
Date: Thu, 28 Oct 2004 03:18:18 -0400
User-Agent: KMail/1.7
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
References: <41808419.8070104@metaparadigm.com> <41808A20.2030408@metaparadigm.com>
In-Reply-To: <41808A20.2030408@metaparadigm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200410280318.18430.phillips@istop.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 October 2004 01:56, Michael Clark wrote:
> > In 2.6.9, the compile completes okay although I see the page
> > allocation failures logged below. I'm guessing they are not
> > critical and the process faulting on the page to swap in will
> > just sleep and retry again later??

What happens in 2.6.8.1?

Regards,

Daniel
