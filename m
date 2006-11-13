Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755147AbWKMQk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755147AbWKMQk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Nov 2006 11:40:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755156AbWKMQk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Nov 2006 11:40:58 -0500
Received: from sj-iport-6.cisco.com ([171.71.176.117]:54552 "EHLO
	sj-iport-6.cisco.com") by vger.kernel.org with ESMTP
	id S1755147AbWKMQk5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Nov 2006 11:40:57 -0500
X-IronPort-AV: i="4.09,418,1157353200"; 
   d="scan'208"; a="87894105:sNHT45354294"
To: Christoph Raisch <RAISCH@de.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
       linuxppc-dev@ozlabs.org, openib-general@openib.org,
       openib-general-bounces@openib.org
Subject: Re: [openib-general] [PATCH 2.6.19 2/4] ehca: hcp_phyp.c: correct page mapping in 64k page mode
X-Message-Flag: Warning: May contain useful information
References: <OFEBD51474.F7DD1031-ONC1257225.0032352E-C1257225.005B569D@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 13 Nov 2006 08:40:48 -0800
In-Reply-To: <OFEBD51474.F7DD1031-ONC1257225.0032352E-C1257225.005B569D@de.ibm.com> (Christoph Raisch's message of "Mon, 13 Nov 2006 17:40:52 +0100")
Message-ID: <adabqnb5mgf.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.19 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 13 Nov 2006 16:40:48.0869 (UTC) FILETIME=[795C8150:01C70742]
Authentication-Results: sj-dkim-4; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim4002 verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 > So Roland, feel free to ignore that line where we do the calculation.

OK, ignore the email I just sent.  I'll drop the patch.

thanks
