Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262813AbVCDAsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbVCDAsb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Mar 2005 19:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVCDAoe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Mar 2005 19:44:34 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:59397 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S262813AbVCDAn2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Mar 2005 19:43:28 -0500
To: "'Jeff Garzik'" <jgarzik@pobox.com>, <akpm@osdl.org>,
       <linux-kernel@vger.kernel.org>, <openib-general@openib.org>
Subject: Re: [openib-general] Re: [PATCH][26/26] IB: MAD cancel callbacks
 fromthread
X-Message-Flag: Warning: May contain useful information
References: <ORSMSX401FRaqbC8wSA0000000e@orsmsx401.amr.corp.intel.com>
From: Roland Dreier <roland@topspin.com>
Date: Thu, 03 Mar 2005 16:43:26 -0800
In-Reply-To: <ORSMSX401FRaqbC8wSA0000000e@orsmsx401.amr.corp.intel.com> (Sean
 Hefty's message of "Thu, 3 Mar 2005 16:34:43 -0800")
Message-ID: <52fyzcnsup.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 04 Mar 2005 00:43:26.0988 (UTC) FILETIME=[2DA1CCC0:01C52053]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    >> don't add casts to a void pointer, that's silly.

How should we handle this nit?  Should I post a new version of this
patch or an incremental diff that fixes it up?

 - R.
