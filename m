Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262115AbTIEFvc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Sep 2003 01:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262230AbTIEFvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Sep 2003 01:51:32 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:43007 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S262115AbTIEFvb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Sep 2003 01:51:31 -0400
Date: Fri, 5 Sep 2003 07:42:59 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: linux-kernel@vger.kernel.org, linux-acpi <linux-acpi@intel.com>
Subject: Re: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
Message-ID: <20030905054259.GA9940@pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
References: <7F740D512C7C1046AB53446D3720017304AEF1@scsmsx402.sc.intel.com> <20030902061959.GA29263@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030902061959.GA29263@pwr.wroc.pl>
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: OpenPGP or S/MIME encrypted e-mail is welcome.
X-01-Privacy-Policy-GPG-Key: http://blackhole.pca.dfn.de:11371/pks/lookup?search=dzieko@pwr.wroc.pl&op=get
X-02-Privacy-Policy-GPG-Key_ID: 5AA7253D
X-03-Privacy-Policy-GPG-Key_fingerprint: A80B 5022 185B 1BB5 8848  74C4 A7E1 423C 5AA7 253D
X-04-Privacy-Policy-Personal_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=00000069&certdir=/usr/local/cafe/data/polish_ca/certs_31.12.2002/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On wto, 02 wrz 2003 at 08:19:59  +0200, Pawel Dziekonski wrote:
> On pon, 01 wrz 2003 at 07:07:32  -0700, Nakajima, Jun wrote:
> > Can you try the following patch that I sent out the other day? I saw
> > this message when I was debugging, and it's gone with the patch. I
> > assume you have ACPI enabled.

works! thanks, P
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
