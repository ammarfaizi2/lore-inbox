Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262346AbTHaOOX (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Aug 2003 10:14:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262255AbTHaOMZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Aug 2003 10:12:25 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:34557 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S262210AbTHaOL1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Aug 2003 10:11:27 -0400
Date: Sun, 31 Aug 2003 16:11:25 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: linux-kernel@vger.kernel.org
Subject: 2.4.22-ac1 -- loading of usb-uhci gives hard lockup
Message-ID: <20030831141125.GA4402@pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hi,

clean 2.4.22-ac1, load of usb-uhci.o locks my machine hard :-(
it was working OK with 2.4.22-rc2-ac2! machine is on KT133 chipset.
I cant use plain 2.4.22 because of trouble of compiling it with XFS
support (unofficial patch has no .config entries).
any suggestions? regards, P
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy info.
