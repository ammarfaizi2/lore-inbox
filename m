Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270416AbTHGTuY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Aug 2003 15:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270455AbTHGTuY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Aug 2003 15:50:24 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:42984 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S270416AbTHGTuV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Aug 2003 15:50:21 -0400
Date: Thu, 7 Aug 2003 21:49:53 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: Tomas Szepe <szepe@pinerecords.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre10-ac1 -- lots of unresolved symbols
Message-ID: <20030807194953.GA15747@pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
References: <20030807133053.GA18191@pwr.wroc.pl> <20030807140232.GC7094@louise.pinerecords.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030807140232.GC7094@louise.pinerecords.com>
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

On czw, 07 sie 2003 at 04:02:32  +0200, Tomas Szepe wrote:
> > [pawel.dziekonski@pwr.wroc.pl]
> > 
> > I just got lots of unresolved symbols for 2.4.22-pre10-ac1, please help.
> > thanks in advance, P
> 
> Save your .config, "make mrproper", cp in your .config, "make oldconfig",
> rebuild.
> 
> There are certain config options (for instance SMP) the toggling of which
> requires this procedure.

same effect :(
P
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
