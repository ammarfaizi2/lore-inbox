Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265059AbTFYUuI (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 16:50:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265060AbTFYUuI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 16:50:08 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:32521 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265059AbTFYUtw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 16:49:52 -0400
Date: Wed, 25 Jun 2003 22:03:58 +0100
From: Christoph Hellwig <hch@infradead.org>
To: mocm@mocm.de
Cc: =?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       Marcus Metzler <mocm@metzlerbros.de>,
       Michael Hunold <hunold@convergence.de>, Sam Ravnborg <sam@ravnborg.org>,
       linux-kernel@vger.kernel.org
Subject: Re: DVB Include files
Message-ID: <20030625220358.B13814@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, mocm@mocm.de,
	=?iso-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
	Marcus Metzler <mocm@metzlerbros.de>,
	Michael Hunold <hunold@convergence.de>,
	Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
References: <20030625182409.A29252@infradead.org> <16121.56382.444838.485646@sheridan.metzler> <20030625185036.C29537@infradead.org> <16121.58735.59911.813354@sheridan.metzler> <20030625191532.A1083@infradead.org> <16121.60747.537424.961385@sheridan.metzler> <20030625194250.GF1770@wohnheim.fh-wedel.de> <16122.379.321217.737557@sheridan.metzler> <20030625202312.GG1770@wohnheim.fh-wedel.de> <16122.2724.417649.622538@sheridan.metzler>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16122.2724.417649.622538@sheridan.metzler>; from mocm@metzlerbros.de on Wed, Jun 25, 2003 at 10:48:36PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 25, 2003 at 10:48:36PM +0200, Marcus Metzler wrote:
> That was kind of the point. If I have to check and copy the includes
> all the time I may run into trouble because of such changes. Whereas
> without that, I only have to recompile. I don't have to check each and
> evry possible place where old headers may be, which may even be
> different for every distribution.

If that's your attitude we should drop dvb from the kernel again.  The Linux
Kernel has a stable userspace ABI.

