Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318170AbSIFACI>; Thu, 5 Sep 2002 20:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318265AbSIFACI>; Thu, 5 Sep 2002 20:02:08 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:62984 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S318170AbSIFACH>; Thu, 5 Sep 2002 20:02:07 -0400
Date: Fri, 6 Sep 2002 01:06:41 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>,
       JFS-Discussion <jfs-discussion@www-124.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [OOPS:2.5.33] Re: [Jfs-discussion] crash with JFS assert
Message-ID: <20020906010641.A24706@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	JFS-Discussion <jfs-discussion@www-124.ibm.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.43.0209051006480.887-100000@leo.uni-sw.gwdg.de> <3D771308.6030009@hh59.org> <200209050755.06015.shaggy@austin.ibm.com> <20020906000040.GA269@prester.freenet.de> <20020906000250.GB269@prester.freenet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020906000250.GB269@prester.freenet.de>; from axel@hh59.org on Fri, Sep 06, 2002 at 02:02:50AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 06, 2002 at 02:02:50AM +0200, Axel Siebenwirth wrote:
> Since I have once encountered an oops that was only caused when I had two
> certain config options enabled, I though it would also be useful to attach
> my .config.

This is 2.5.33 + akpm's patchkit, right?  CONFIG_PREEMPT worries me,
although I wonder whether JFS might be affected by similar problem NFS
is, although I can't see any relation.

