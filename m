Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317351AbSHWJn7>; Fri, 23 Aug 2002 05:43:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317359AbSHWJn7>; Fri, 23 Aug 2002 05:43:59 -0400
Received: from phoenix.mvhi.com ([195.224.96.167]:55313 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317351AbSHWJn7>; Fri, 23 Aug 2002 05:43:59 -0400
Date: Fri, 23 Aug 2002 10:47:44 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Stephen Tweedie <sct@redhat.com>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>, linux-kernel@vger.kernel.org
Subject: Re: [Patch 0/2] 2.4.20-pre4/ext3: ext3 dirty buffer management
Message-ID: <20020823104744.A12076@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Stephen Tweedie <sct@redhat.com>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	linux-kernel@vger.kernel.org
References: <200208222319.g7MNJY509078@sisko.scot.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208222319.g7MNJY509078@sisko.scot.redhat.com>; from sct@redhat.com on Fri, Aug 23, 2002 at 12:19:34AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 23, 2002 at 12:19:34AM +0100, Stephen Tweedie wrote:
> Hi Marcelo, 
> 
> This patch set contains the biggest recent change to ext3: a change to
> the way it deals with other dirty buffers in the system, making it
> robust against things like dump(8) or tune2fs(8) playing with the block
> device on a live filesystem.  This patch has been in ext3 CVS for some
> time now.
> 
> I'll follow up with the other smaller fixes and tweaks in the next
> batch.

No patch attached..
