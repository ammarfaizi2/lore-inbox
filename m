Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317278AbSH0V2t>; Tue, 27 Aug 2002 17:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317282AbSH0V2t>; Tue, 27 Aug 2002 17:28:49 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:30727 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317278AbSH0V2s>; Tue, 27 Aug 2002 17:28:48 -0400
Date: Tue, 27 Aug 2002 22:33:01 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Juan Gomez <juang@us.ibm.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: NFS lockd patch proposal for user-level control of the grace period
Message-ID: <20020827223301.A6767@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Juan Gomez <juang@us.ibm.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	linux-kernel@vger.kernel.org
References: <OF05D43610.2879BBAC-ON87256C22.0073ADF3@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <OF05D43610.2879BBAC-ON87256C22.0073ADF3@us.ibm.com>; from juang@us.ibm.com on Tue, Aug 27, 2002 at 03:06:33PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 27, 2002 at 03:06:33PM -0600, Juan Gomez wrote:
> Following up with Alan request here I am sending a patch for fs/lockd/svc.c
> that contains the grace period control feature through the proc filesystem,
> feedback & sugestions are very welcome as is the prompt inclusion in the
> linux distribution :-)

What do you need this for eaxctly?

> (See attached file: userl-gracep-control.patch)

Would be much nicer if inlined and in unified diff format.

Please follow Documentation/CodingStyle and i think for that purpose sysctl
are much better than procfs

