Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262255AbVDFQoY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262255AbVDFQoY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 12:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262256AbVDFQoY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 12:44:24 -0400
Received: from ns1.s2io.com ([142.46.200.198]:33245 "EHLO ns1.s2io.com")
	by vger.kernel.org with ESMTP id S262255AbVDFQoS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 12:44:18 -0400
Subject: Re: AOE and large filesystems?
From: Dmitry Yusupov <dima@neterion.com>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Dan Stromberg <strombrg@dcs.nac.uci.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <42531A42.90508@pobox.com>
References: <pan.2005.04.05.20.44.39.37209@dcs.nac.uci.edu>
	 <42531A42.90508@pobox.com>
Content-Type: text/plain
Organization: Neterion, Inc
Date: Wed, 06 Apr 2005 09:44:06 -0700
Message-Id: <1112805846.16753.46.camel@beastie>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-2) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: -102.5
X-Spam-Outlook-Score: ()
X-Spam-Features: EMAIL_ATTRIBUTION,IN_REP_TO,QUOTED_EMAIL_TEXT,REFERENCES,REPLY_WITH_QUOTES,USER_IN_WHITELIST
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-04-05 at 19:07 -0400, Jeff Garzik wrote:
> As a tangent, I'd also like to see iSCSI over SCTP.

existing iSCSI over TCP ietf draft just does not fit into SCTP.

There was some activity on IPS recently:

http://www1.ietf.org/mail-archive/web/ips/current/msg01279.html

it ends up with needs for new ietf draft which will describe iSCSI over
SCTP transport.

Dmitry

> 	Jeff
> 
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

