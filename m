Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263298AbUJ2Mtn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263298AbUJ2Mtn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 08:49:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263306AbUJ2Mtn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 08:49:43 -0400
Received: from canuck.infradead.org ([205.233.218.70]:11792 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S263298AbUJ2Mtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 08:49:41 -0400
Subject: Re: Linuxant/Conexant HSF/HCF Modem Drivers Unlocked
From: Arjan van de Ven <arjan@infradead.org>
To: typo@shaw.ca
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Paulo Marques <pmarques@grupopie.com>
In-Reply-To: <1099053788.4511.13.camel@localhost>
References: <1099032721.23148.5.camel@localhost>
	 <418226FA.1030803@grupopie.com>  <1099053788.4511.13.camel@localhost>
Content-Type: text/plain
Message-Id: <1099054168.2641.23.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Fri, 29 Oct 2004 14:49:28 +0200
Content-Transfer-Encoding: 7bit
X-Spam-Score: 2.6 (++)
X-Spam-Report: SpamAssassin version 2.63 on canuck.infradead.org summary:
	Content analysis details:   (2.6 points, 5.0 required)
	pts rule name              description
	---- ---------------------- --------------------------------------------------
	2.5 RCVD_IN_DYNABLOCK      RBL: Sent directly from dynamic IP address
	[62.195.31.207 listed in dnsbl.sorbs.net]
	0.1 RCVD_IN_SORBS          RBL: SORBS: sender is listed in SORBS
	[62.195.31.207 listed in dnsbl.sorbs.net]
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by canuck.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-10-29 at 06:43 -0600, Chad Christopher Giffin wrote:
> On Fri, 2004-10-29 at 12:18 +0100, Paulo Marques wrote:
> > Chad Christopher Giffin wrote:
> > > I couldn't help but notice that the Linuxant Modem drivers appear to be
> > > GPL'd, as a strings of the modules shows that License=GPL.
> > 

if linuxant is still doing this crap... what about putting the \0
checker in the module loader after all....


