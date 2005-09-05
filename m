Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932477AbVIEUYH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932477AbVIEUYH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 16:24:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932481AbVIEUYH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 16:24:07 -0400
Received: from quechua.inka.de ([193.197.184.2]:26602 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id S932477AbVIEUYG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 16:24:06 -0400
Date: Mon, 5 Sep 2005 22:24:03 +0200
From: Bernd Eckenfels <be-mail2005@lina.inka.de>
To: linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Message-ID: <20050905202403.GB7580@lina.inka.de>
References: <20050903070639.GC4593@ca-server1.us.oracle.com> <E1EBSRB-0003lW-00@calista.eckenfels.6bone.ka-ip.net> <20050905141631.GG5498@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905141631.GG5498@marowsky-bree.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 04:16:31PM +0200, Lars Marowsky-Bree wrote:
> That is the whole point why OCFS exists ;-)

The whole point of the orcacle cluster filesystem as it was described in old
papers was about pfiles, control files and software, because you can easyly
use direct block access (with ASM) for tablespaces.

> No. Beyond the table spaces, there's also ORACLE_HOME; a cluster
> benefits in several aspects from a general-purpose SAN-backed CFS.

Yes, I dont dispute the usefullness of OCFS for ORA_HOME (beside I think a
replicated filesystem makes more sense), I am just nor sure if anybody sane
would use it for tablespaces.

I guess I have to correct the artile in my german it blog :) (if somebody
can name productive customers).

Gruss
Bernd
-- 
http://itblog.eckenfels.net/archives/54-Cluster-Filesysteme.html
