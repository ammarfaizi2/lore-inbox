Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270740AbUJUPAx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270740AbUJUPAx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 11:00:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262406AbUJUO7F
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 10:59:05 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:65041 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S270465AbUJUOiX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 10:38:23 -0400
Date: Thu, 21 Oct 2004 09:33:22 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: Arjan van de Ven <arjan@fenrus.demon.nl>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
       davem@davemloft.net, john.ronciak@intel.com,
       ganesh.venkatesan@intel.com, akpm@osdl.org, romieu@fr.zoreil.com,
       ctindel@users.sourceforge.net, fubar@us.ibm.com,
       greearb@candelatech.com
Subject: Re: [patch 2.6.9 0/11] Add MODULE_VERSION to several network drivers
Message-ID: <20041021093322.E29340@tuxdriver.com>
Mail-Followup-To: Arjan van de Ven <arjan@fenrus.demon.nl>,
	netdev@oss.sgi.com, linux-kernel@vger.kernel.org, jgarzik@pobox.com,
	davem@davemloft.net, john.ronciak@intel.com,
	ganesh.venkatesan@intel.com, akpm@osdl.org, romieu@fr.zoreil.com,
	ctindel@users.sourceforge.net, fubar@us.ibm.com,
	greearb@candelatech.com
References: <20041020141146.C8775@tuxdriver.com> <1098350269.2810.17.camel@laptop.fenrus.com> <20041021082205.A29340@tuxdriver.com> <1098366370.2810.31.camel@laptop.fenrus.com> <20041021085509.B29340@tuxdriver.com> <1098367875.2810.36.camel@laptop.fenrus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1098367875.2810.36.camel@laptop.fenrus.com>; from arjan@fenrus.demon.nl on Thu, Oct 21, 2004 at 04:11:17PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 21, 2004 at 04:11:17PM +0200, Arjan van de Ven wrote:
> On Thu, 2004-10-21 at 14:55, John W. Linville wrote:

> > Again, I think it would have to be the maintainer's responsibility
> > to make the version numbers meaningful.
> 
> absolutely; however you're not the maintainer of all of the ones you
> patched... and I still argue that until the number is meaningful
> exporting it as meaning something is more harm than good.

As you say, I'm not the maintainer.  I just proposed the patches.

It seems you are not really talking to me.  Instead, you are telling the
maintainers that by applying these patches, they should be committing
themselves to making/keeping the version numbers meaningful?

John
-- 
John W. Linville
linville@tuxdriver.com
