Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263173AbTJaKGy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 05:06:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263181AbTJaKGy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 05:06:54 -0500
Received: from pub234.cambridge.redhat.com ([213.86.99.234]:33799 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S263173AbTJaKGx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 05:06:53 -0500
Date: Fri, 31 Oct 2003 10:06:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Kurt Garloff <garloff@suse.de>,
       Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
       linux-kernel@vger.kernel.org, Matthias Andree <matthias.andree@gmx.de>
Subject: Re: [PATCH] Re: AMD 53c974 SCSI driver in 2.6
Message-ID: <20031031100651.A15290@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Kurt Garloff <garloff@suse.de>,
	Guennadi Liakhovetski <g.liakhovetski@gmx.de>,
	linux-kernel@vger.kernel.org,
	Matthias Andree <matthias.andree@gmx.de>
References: <Pine.LNX.4.44.0310262035270.3346-100000@poirot.grange> <Pine.LNX.4.44.0310302221400.5533-100000@poirot.grange> <20031030235204.GF2716@tpkurt.garloff.de> <20031031094742.B14820@infradead.org> <20031031095910.GD2716@tpkurt.garloff.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031031095910.GD2716@tpkurt.garloff.de>; from garloff@suse.de on Fri, Oct 31, 2003 at 10:59:10AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 31, 2003 at 10:59:10AM +0100, Kurt Garloff wrote:
> On Fri, Oct 31, 2003 at 09:47:42AM +0000, Christoph Hellwig wrote:
> > Any reason why we'd keep both drivers?  Given that there's not much ressources
> > for fixing drivers for older hardware I'd rather see us not keeping multiple
> > drivers for the same hardware.
> 
> As long as there are people willing to do the work, there's no reason to
> drop any of them.

Well, yes.  If we had two properly maintained drivers there would be
no reason to drop one.  But we currently have two broken drivers, one of
them just resurrected to compiling and mostly working on UP state..

--
Christoph Hellwig <hch@lst.de>		-	Freelance Hacker
Contact me for driver hacking and kernel development consulting

