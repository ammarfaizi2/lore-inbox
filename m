Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262081AbVD1PE6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262081AbVD1PE6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 11:04:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262109AbVD1PE6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 11:04:58 -0400
Received: from dsl027-162-124.atl1.dsl.speakeasy.net ([216.27.162.124]:33218
	"EHLO kevlar.burdell.org") by vger.kernel.org with ESMTP
	id S262081AbVD1PEx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 11:04:53 -0400
Date: Thu, 28 Apr 2005 10:44:15 -0400
From: Sonny Rao <sonny@burdell.org>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 0/4] ppc64: Introduce BPA platform
Message-ID: <20050428144415.GA28779@kevlar.burdell.org>
Mail-Followup-To: Sonny Rao <sonny@burdell.org>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc64-dev@ozlabs.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
References: <200504190318.32556.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200504190318.32556.arnd@arndb.de>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 28, 2005 at 09:54:00AM +0200, Arnd Bergmann wrote:
> This series of patches add support for a fifth platform type in the
> ppc64 architecture tree. The Broadband Processor Architecture (BPA)
> is currently used in a single machine from IBM, with others likely
> to be added at a later point.
> 
> I already sent preparation patches before, these need to be applied
> on top of them.
> The first three patches add the actual platform code, which should
> be usable for any BPA compatible implementation.
> 
> The final patch introduces a new file system to make use of the
> SPUs inside the processors. This patch is still in a prototype stage
> and not intended for merging yet.
> 
> 	Arnd <><

Is BPA the same thing (architecture) as the STI Cell Processor?

Sonny
