Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262158AbSKCQXr>; Sun, 3 Nov 2002 11:23:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262184AbSKCQXr>; Sun, 3 Nov 2002 11:23:47 -0500
Received: from stine.vestdata.no ([195.204.68.10]:14798 "EHLO
	stine.vestdata.no") by vger.kernel.org with ESMTP
	id <S262158AbSKCQXq>; Sun, 3 Nov 2002 11:23:46 -0500
Date: Sun, 3 Nov 2002 17:30:16 +0100
From: =?iso-8859-1?Q?Ragnar_Kj=F8rstad?= <kernel@ragnark.vestdata.no>
To: Bernd Eckenfels <ecki-news2002-09@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Filesystem Capabilities in 2.6?
Message-ID: <20021103173016.E30076@vestdata.no>
References: <1036328263.29642.23.camel@irongate.swansea.linux.org.uk> <E188MXo-00074b-00@sites.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <E188MXo-00074b-00@sites.inka.de>; from ecki-news2002-09@lina.inka.de on Sun, Nov 03, 2002 at 04:20:08PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 03, 2002 at 04:20:08PM +0100, Bernd Eckenfels wrote:
> In article <1036328263.29642.23.camel@irongate.swansea.linux.org.uk> you wrote:
> > Namespaces is a way to inherit revocation of rights on a large scale (or
> > a small one true). #! is a way to handle program specific revocation of
> > rights which _is_ filesystem persistent.
> 
> #! would be a nice option to increase capabilities on invocation. But the
> final target must be linked to the invocation by an entity/revision binding.
> Since we do not have modification versions i could think about checksums:

Unfortenately it will be much harder to find all executables with
increased capabilities on your system. 


-- 
Ragnar Kjørstad
Big Storage
