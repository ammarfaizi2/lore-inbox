Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317854AbSGPNC6>; Tue, 16 Jul 2002 09:02:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317855AbSGPNC5>; Tue, 16 Jul 2002 09:02:57 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:47374 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S317854AbSGPNC4>; Tue, 16 Jul 2002 09:02:56 -0400
Date: Tue, 16 Jul 2002 14:05:49 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org, Stelian Pop <stelian.pop@fr.alcove.com>,
       Sam Vilain <sam@vilain.net>, dax@gurulabs.com
Subject: Re: [ANNOUNCE] Ext3 vs Reiserfs benchmarks
Message-ID: <20020716140549.A11780@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org,
	Stelian Pop <stelian.pop@fr.alcove.com>,
	Sam Vilain <sam@vilain.net>, dax@gurulabs.com
References: <1026679245.15054.9.camel@thud> <E17U1BD-0000m0-00@hofmann> <1026736251.13885.108.camel@irongate.swansea.linux.org.uk> <E17U4YE-0000TL-00@hofmann> <20020715160357.GD442@clusterfs.com> <E17U9x9-0001Dc-00@hofmann> <20020716081531.GD7955@tahoe.alcove-fr> <20020716122756.GD4576@merlin.emma.line.org> <20020716124331.GJ7955@tahoe.alcove-fr> <20020716125301.GI4576@merlin.emma.line.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020716125301.GI4576@merlin.emma.line.org>; from matthias.andree@stud.uni-dortmund.de on Tue, Jul 16, 2002 at 02:53:01PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 16, 2002 at 02:53:01PM +0200, Matthias Andree wrote:
> Not if some day somebody implements file system level snapshots for
> Linux. Until then, better have garbled file contents constrained to a
> file than random data as on-disk layout changes with hefty directory
> updates.

or the blockdevice-level snapshots already implemented in Linux..

