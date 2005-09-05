Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751270AbVIEOR2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751270AbVIEOR2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 10:17:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751276AbVIEOR2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 10:17:28 -0400
Received: from gate.in-addr.de ([212.8.193.158]:9858 "EHLO mx.in-addr.de")
	by vger.kernel.org with ESMTP id S1751270AbVIEOR2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 10:17:28 -0400
Date: Mon, 5 Sep 2005 16:16:31 +0200
From: Lars Marowsky-Bree <lmb@suse.de>
To: Bernd Eckenfels <ecki@lina.inka.de>, linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Message-ID: <20050905141631.GG5498@marowsky-bree.de>
References: <20050903070639.GC4593@ca-server1.us.oracle.com> <E1EBSRB-0003lW-00@calista.eckenfels.6bone.ka-ip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E1EBSRB-0003lW-00@calista.eckenfels.6bone.ka-ip.net>
X-Ctuhulu: HASTUR
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2005-09-03T09:27:41, Bernd Eckenfels <ecki@lina.inka.de> wrote:

> Oh thats interesting, I never thought about putting data files (tablespaces)
> in a clustered file system. Does that mean you can run supported RAC on
> shared ocfs2 files and anybody is using that?

That is the whole point why OCFS exists ;-)

> Do you see this go away with ASM?

No. Beyond the table spaces, there's also ORACLE_HOME; a cluster
benefits in several aspects from a general-purpose SAN-backed CFS.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
High Availability & Clustering
SUSE Labs, Research and Development
SUSE LINUX Products GmbH - A Novell Business	 -- Charles Darwin
"Ignorance more frequently begets confidence than does knowledge"

