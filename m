Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263253AbTDVQvg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Apr 2003 12:51:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263259AbTDVQvg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Apr 2003 12:51:36 -0400
Received: from c-51a870d5.037-69-73746f23.cust.bredbandsbolaget.se ([213.112.168.81]:24968
	"EHLO zaphod.guide") by vger.kernel.org with ESMTP id S263253AbTDVQvd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Apr 2003 12:51:33 -0400
To: war <war@lucidpixels.com>
Cc: linux-kernel@vger.kernel.org, copycat@jx165.net
Subject: Re: HPT366/368/370 IDE/SCSI-EMULATION PROBLEMS (2.4.x)
References: <Pine.LNX.4.55.0304221213510.25378@p300>
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Date: 22 Apr 2003 19:03:02 +0200
In-Reply-To: <Pine.LNX.4.55.0304221213510.25378@p300>
Message-ID: <yw1xsmsaihx5.fsf@zaphod.guide>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) XEmacs/21.4 (Portable Code)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

war <war@lucidpixels.com> writes:

> Is it possible to have HPT rocket ATA/100 cards (3 of them) see hard
> drives as IDE and not SCSI?

I have one of those boards (actually the SATA version) and it works
like a charm with both 2.4.21-pre5 and 2.5.67.

-- 
Måns Rullgård
mru@users.sf.net
