Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261321AbUEVNwK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261321AbUEVNwK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 09:52:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261347AbUEVNwK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 09:52:10 -0400
Received: from sun1000.pwr.wroc.pl ([156.17.1.33]:14219 "EHLO
	sun1000.pwr.wroc.pl") by vger.kernel.org with ESMTP id S261321AbUEVNwI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 09:52:08 -0400
Date: Sat, 22 May 2004 15:51:59 +0200
From: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [solved] Re: [2.6.6] [usb] bad: scheduling while atomic!
Message-ID: <20040522135159.GA25948@sun1000.pwr.wroc.pl>
Reply-To: Pawel Dziekonski <pawel.dziekonski@pwr.wroc.pl>
References: <20040521224531.GA15538@sun1000.pwr.wroc.pl> <20040521235229.GB13404@kroah.com> <20040522114204.GA25141@sun1000.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040522114204.GA25141@sun1000.pwr.wroc.pl>
X-Useless-Header: Vim powered ;^)
X-00-Privacy-Policy: S/MIME encrypted e-mail is welcome.
X-04-Privacy-Policy-My_SSL_Certificate: http://www.europki.pl/cgi-bin/dn-cert.pl?serial=000001D2&certdir=/usr/local/cafe/data/polish_ca/certs/user&type=email
X-05-Privacy-Policy-CA_SSL_Certificate: http://www.europki.pl/polish_ca/ca_cert/en_index.html
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok, driver bug, solved by its devel team.
thanks greg!
-- 
Pawel Dziekonski <pawel.dziekonski|@|pwr.wroc.pl>, KDM WCSS avatar:0:0:
Wroclaw Networking & Supercomputing Center, HPC Department
-> See message headers for privacy policy and S/MIME info.
