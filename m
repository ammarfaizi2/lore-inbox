Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262766AbUDPI22 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Apr 2004 04:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUDPI22
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Apr 2004 04:28:28 -0400
Received: from mail.shareable.org ([81.29.64.88]:31906 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262766AbUDPI20
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Apr 2004 04:28:26 -0400
Date: Fri, 16 Apr 2004 09:27:30 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Len Brown <len.brown@intel.com>
Cc: Allen Martin <AMartin@nvidia.com>, ross@datscreative.com.au,
       Christian =?iso-8859-1?Q?Kr=F6ner?= 
	<christian.kroener@tu-harburg.de>,
       Linux-Nforce-Bugs <Linux-Nforce-Bugs@exchange.nvidia.com>,
       linux-kernel@vger.kernel.org, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Subject: Re: IO-APIC on nforce2 [PATCH]
Message-ID: <20040416082730.GB22226@mail.shareable.org>
References: <DCB9B7AA2CAB7F418919D7B59EE45BAF49FB9D@mail-sc-6-bk.nvidia.com> <1082058625.24423.161.camel@dhcppc4>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1082058625.24423.161.camel@dhcppc4>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> As we expected, an automatic workaround based on chip-set would
> fail because some BIOS's are fixed and some are not.

Does the workaround actually fail with the fixed BIOSes?

-- Jamie
