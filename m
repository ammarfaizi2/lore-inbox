Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262324AbVCBPE2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262324AbVCBPE2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Mar 2005 10:04:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262328AbVCBPE2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Mar 2005 10:04:28 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:23970 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262324AbVCBPEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Mar 2005 10:04:25 -0500
Subject: Re: investingating kernel :Cnx error
From: Arjan van de Ven <arjan@infradead.org>
To: bhamal@wlink.com.np
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <000401c51edd$ae348390$0db3fea9@kath.state.gov>
References: <000401c51edd$ae348390$0db3fea9@kath.state.gov>
Content-Type: text/plain
Date: Wed, 02 Mar 2005 16:04:20 +0100
Message-Id: <1109775860.6291.118.camel@laptopd505.fenrus.org>
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

On Wed, 2005-03-02 at 09:52 +0545, bj wrote:
> Hi !
> 
> I am using Red Hat 8 with kernel 2.4.20-30.8.legacy
> 
> I am facing the following error some times  .
> 
> It hangs my computer when I am doing a make or am using x-windows .
> 
> How do I go about investigating the cause of it ?
> 
> Thank you for your help.
which binary module are you using ?


