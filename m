Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262351AbVCIMlf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262351AbVCIMlf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Mar 2005 07:41:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262344AbVCIMlf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Mar 2005 07:41:35 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:234 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262351AbVCIMkh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Mar 2005 07:40:37 -0500
Subject: Re: "remap_page_range" compile ERROR
From: Arjan van de Ven <arjan@infradead.org>
To: "Mukund JB." <mukundjb@esntechnologies.co.in>
Cc: linux-kernel@vger.kernel.org, alan@lxorguk.ukuu.org.uk, martin.frey@scs.ch
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348113A4897@mail.esn.co.in>
References: <4EE0CBA31942E547B99B3D4BFAB348113A4897@mail.esn.co.in>
Content-Type: text/plain
Date: Wed, 09 Mar 2005 13:40:28 +0100
Message-Id: <1110372029.6280.94.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on pentafluge.infradead.org summary:
	Content analysis details:   (4.1 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	0.3 RCVD_NUMERIC_HELO      Received: contains a numeric HELO
	1.1 RCVD_IN_DSBL           RBL: Received via a relay in list.dsbl.org
	[<http://dsbl.org/listing?80.57.133.107>]
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[80.57.133.107 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[80.57.133.107 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Please suggest me what could be the problem.

the problem is that you are using a way way way too old kernel. I
suggest you fix that first ....

