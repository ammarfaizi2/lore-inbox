Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262371AbUJ0KVx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262371AbUJ0KVx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 06:21:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262377AbUJ0KUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 06:20:46 -0400
Received: from canuck.infradead.org ([205.233.218.70]:62220 "EHLO
	canuck.infradead.org") by vger.kernel.org with ESMTP
	id S262353AbUJ0KKA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 06:10:00 -0400
Subject: Re: 2.4.28-rc1, more lost patches [6/10]
From: Arjan van de Ven <arjan@infradead.org>
To: sezeroz@ttnet.net.tr
Cc: linux-kernel@vger.kernel.org, marcelo.tosatti@cyclades.com
In-Reply-To: <20041027094036.KAGS6935.fep01.ttnet.net.tr@localhost>
References: <20041027094036.KAGS6935.fep01.ttnet.net.tr@localhost>
Content-Type: text/plain
Message-Id: <1098871777.4680.15.camel@laptop.fenrus.org>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2.dwmw2.1) 
Date: Wed, 27 Oct 2004 12:09:37 +0200
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

On Wed, 2004-10-27 at 12:40 +0300, sezeroz@ttnet.net.tr wrote:
> [6/10] cdrom: If the device is opened O_EXCL but there are
> other openers, return busy. From ac/redhat. (by Arjan??)

this is a "feature" patch not a strict bugfix, so I'm not convinced it's
suitable for 2.4 inclusion anymore.

-- 

