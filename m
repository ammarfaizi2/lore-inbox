Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319021AbSHTPGx>; Tue, 20 Aug 2002 11:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319046AbSHTPGx>; Tue, 20 Aug 2002 11:06:53 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:50443 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319021AbSHTPGw>; Tue, 20 Aug 2002 11:06:52 -0400
Date: Tue, 20 Aug 2002 16:10:46 +0100
From: Christoph Hellwig <hch@infradead.org>
To: jack@suse.cz
Cc: "Dmitry N. Hramtsov" <hdn@nsu.ru>, linux-kernel@vger.kernel.org
Subject: Re: vfsv0 quota patch
Message-ID: <20020820161046.A26295@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, jack@suse.cz,
	"Dmitry N. Hramtsov" <hdn@nsu.ru>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0208191220390.28677-100000@aurora.nsu.ru> <20020820162620.G21149@popelka.ms.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020820162620.G21149@popelka.ms.mff.cuni.cz>; from jack@suse.cz on Tue, Aug 20, 2002 at 04:26:20PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 20, 2002 at 04:26:20PM +0200, jack@suse.cz wrote:
>   The computer will be probably offline for a while (as far as I know
>   there are problems with electricity etc...). But you can also
>   use -ac versions of kernel which should contain latest quota patches
>   (actually more recent that on my ftp site...).

Or the quota patch from the 2.4.19 XFS split patches.  It might have some
trivial rejects in Makefile/Config but should work without any problems.

