Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264067AbTEGPrK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:47:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264073AbTEGPrJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:47:09 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:13069 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264067AbTEGPrC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:47:02 -0400
Date: Wed, 7 May 2003 16:59:36 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Michael Hunold <hunold@convergence.de>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
Message-ID: <20030507165935.A29161@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Michael Hunold <hunold@convergence.de>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <3EB7DCF0.2070207@convergence.de> <20030506220828.A19971@infradead.org> <3EB8C67A.4020500@convergence.de> <20030507102256.B14040@infradead.org> <3EB92CAD.2040502@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3EB92CAD.2040502@convergence.de>; from hunold@convergence.de on Wed, May 07, 2003 at 05:56:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 07, 2003 at 05:56:29PM +0200, Michael Hunold wrote:
> I promise that I don't touch the devfs related code anymore.

Oh, you can of course touch it again in future, I just want to
finish the API transition first, I hope I'll be done by the end of this
week.

> But, how do 
> we proceed in general?
> 
> Will the other patches be applied and who does that for which tree?
> Shall I resend the patches where you had objections?

As nothing got in yet I'd suggest resending everything, with Linus you
sometimes may have to resend quite often anyway :)
