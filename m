Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261820AbULaIIO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261820AbULaIIO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 03:08:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbULaIIO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 03:08:14 -0500
Received: from canuck.infradead.org ([205.233.218.70]:44294 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S261820AbULaIHr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 03:07:47 -0500
Subject: Re: kernel panic: Attempted to kill init!
From: Arjan van de Ven <arjan@infradead.org>
To: "Srinivas G." <srinivasg@esntechnologies.co.in>
Cc: linux-kernel-Mailing-list <linux-kernel@vger.kernel.org>
In-Reply-To: <4EE0CBA31942E547B99B3D4BFAB348112B889D@mail.esn.co.in>
References: <4EE0CBA31942E547B99B3D4BFAB348112B889D@mail.esn.co.in>
Content-Type: text/plain
Date: Fri, 31 Dec 2004 09:07:42 +0100
Message-Id: <1104480462.5402.9.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
X-Spam-Score: 4.1 (++++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
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
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-12-31 at 10:10 +0530, Srinivas G. wrote:
> Dear All,

You asked this question on the fedora lists before. I gave you the
answer. Why are you asking it AGAIN but now on this mailing list where
it is somewhat offtopic ?????


(and for those who are not called Srinivas and not subscribed to the
fedora lists; the answer was that if you enable selinux on fedora core
3, you need to run at least a 2.6.9 and preferably a 2.6.10 kernel,
older 2.6 kernels are not new enough selinux wise; and Srinivas was
trying a 2.6.6 kernel)


