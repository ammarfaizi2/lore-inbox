Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275076AbTHLG1y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Aug 2003 02:27:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275079AbTHLG1y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Aug 2003 02:27:54 -0400
Received: from guug.org ([168.234.203.30]:54269 "EHLO guug.galileo.edu")
	by vger.kernel.org with ESMTP id S275076AbTHLG1x (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Aug 2003 02:27:53 -0400
Date: Tue, 12 Aug 2003 00:22:38 -0600
To: Nagendra Singh Tomar <nagendra_tomar@adaptec.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: modprobe: QM_MODULES: Function not implemented ??
Message-ID: <20030812062238.GA28229@guug.org>
References: <Pine.LNX.4.44.0308112338150.1464-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0308112338150.1464-100000@localhost.localdomain>
User-Agent: Mutt/1.5.4i
From: Otto Solares <solca@guug.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 11, 2003 at 11:40:21PM +0530, Nagendra Singh Tomar wrote:
> I am trying to load a module in 2.6.0-test2 downloaded from kernel.org
> I am getting the above error. Probably this means the kernel does not 
> support query_module() interface, but why ?? With 2.4.18 things were 
> absolutely fine. Is it a deprecated interface. 
> Any help is welcome.

you need module-init-tools package, google for it, or
`apt-get install module-init-tools` if in debian sid.

-solca

