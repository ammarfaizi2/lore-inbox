Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261939AbSJNQ0Q>; Mon, 14 Oct 2002 12:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261984AbSJNQ0Q>; Mon, 14 Oct 2002 12:26:16 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:40718 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261939AbSJNQ0P>; Mon, 14 Oct 2002 12:26:15 -0400
Date: Mon, 14 Oct 2002 17:32:06 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Derrick J Brashear <shadow@dementia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PATCH: AFS system call registration function (was Re: Two fixes for 2.4.19-pre5-ac3)
Message-ID: <20021014173206.A21036@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Derrick J Brashear <shadow@dementia.org>,
	linux-kernel@vger.kernel.org
References: <20021014152353.A16334@infradead.org> <Pine.LNX.3.96L.1021014102625.5586G-100000@scully.trafford.dementia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.3.96L.1021014102625.5586G-100000@scully.trafford.dementia.org>; from shadow@dementia.org on Mon, Oct 14, 2002 at 10:31:41AM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 14, 2002 at 10:31:41AM -0400, Derrick J Brashear wrote:
> Well, given the previous commentary I would have expected the hook to have
> already existed, and if it had we would have changed to conform to it
> months ago. 

Which hook?

> No disagreement (on that). Do you propose we orphan old versions?  (Which
> isn't to say "Yes" is a wrong answer)

For plattforms where your old hack doesn't work (Linux 2.5 and
Red Hat's 8.x vendor tree): yes.

