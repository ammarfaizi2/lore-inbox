Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273902AbRIRU07>; Tue, 18 Sep 2001 16:26:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273900AbRIRU0t>; Tue, 18 Sep 2001 16:26:49 -0400
Received: from ns.caldera.de ([212.34.180.1]:40124 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S273898AbRIRU0l>;
	Tue, 18 Sep 2001 16:26:41 -0400
Date: Tue, 18 Sep 2001 22:26:56 +0200
From: Christoph Hellwig <hch@ns.caldera.de>
To: Hubert Mantel <mantel@suse.de>
Cc: Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
Subject: Re: /proc/partitions hosed in 2.4.9-ac10
Message-ID: <20010918222656.A20408@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch>, Hubert Mantel <mantel@suse.de>,
	Erik Andersen <andersen@codepoet.org>, linux-kernel@vger.kernel.org
In-Reply-To: <20010917151957.A26615@codepoet.org> <200109172240.f8HMel917969@ns.caldera.de> <20010918174029.G6102@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010918174029.G6102@suse.de>; from mantel@suse.de on Tue, Sep 18, 2001 at 05:40:29PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 18, 2001 at 05:40:29PM +0200, Hubert Mantel wrote:
> Hi,
> 
> On Tue, Sep 18, Christoph Hellwig wrote:
> 
> > Could you please try the attached patch agains 2.4.10-pre10?
> 
> Tried it. Does not help.

Can you verify that 2.4.9-ac8+ shows the bug as well?

	Christoph

-- 
Whip me.  Beat me.  Make me maintain AIX.
