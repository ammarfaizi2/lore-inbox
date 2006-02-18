Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750801AbWBRQcg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750801AbWBRQcg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 11:32:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751416AbWBRQcg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 11:32:36 -0500
Received: from sj-iport-3-in.cisco.com ([171.71.176.72]:57486 "EHLO
	sj-iport-3.cisco.com") by vger.kernel.org with ESMTP
	id S1750801AbWBRQcf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 11:32:35 -0500
X-IronPort-AV: i="4.02,127,1139212800"; 
   d="scan'208"; a="407035255:sNHT35178626"
To: Arjan van de Ven <arjan@infradead.org>
Cc: Muli Ben-Yehuda <mulix@mulix.org>, Christoph Hellwig <hch@infradead.org>,
       Greg KH <greg@kroah.com>, Roland Dreier <rolandd@cisco.com>,
       linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       openib-general@openib.org, SCHICKHJ@de.ibm.com, RAISCH@de.ibm.com,
       HNGUYEN@de.ibm.com, MEDER@de.ibm.com
Subject: Re: [PATCH 02/22] Firmware interface code for IB device.
X-Message-Flag: Warning: May contain useful information
References: <20060218005532.13620.79663.stgit@localhost.localdomain>
	<20060218005707.13620.20538.stgit@localhost.localdomain>
	<20060218015808.GB17653@kroah.com> <aday809bewn.fsf@cisco.com>
	<20060218122011.GE911@infradead.org>
	<20060218122631.GA30535@granada.merseine.nu>
	<1140265955.4035.19.camel@laptopd505.fenrus.org>
From: Roland Dreier <rdreier@cisco.com>
Date: Sat, 18 Feb 2006 08:32:28 -0800
In-Reply-To: <1140265955.4035.19.camel@laptopd505.fenrus.org> (Arjan van de
 Ven's message of "Sat, 18 Feb 2006 13:32:35 +0100")
Message-ID: <adazmkoaaqr.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
X-OriginalArrivalTime: 18 Feb 2006 16:32:30.0346 (UTC) FILETIME=[E982EEA0:01C634A8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Arjan> The bigger issue is: if people can't be bothered to do
    Arjan> those steps, why would they be bothered to do this for
    Arjan> maintenance and bugfixes etc etc?  Basically it's now
    Arjan> already a de-facto unmaintained driver....

I don't think that's really a fair statement.  The IBM people have
been active and responsive in maintaining their driving in the
openib.org svn tree.  However, they asked me to post their driver for
review because it would be difficult for them to do it.

IBM people: can you clarify the restrictions you have?  Why do you
feel you can't post your own driver for review?  Will you be able to
post smaller patches to lkml in the future if the driver is merged?

Thanks,
  Roland
