Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289282AbSAPBws>; Tue, 15 Jan 2002 20:52:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289290AbSAPBwi>; Tue, 15 Jan 2002 20:52:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22021 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S289282AbSAPBw3>;
	Tue, 15 Jan 2002 20:52:29 -0500
Date: Wed, 16 Jan 2002 01:52:28 +0000
From: Joel Becker <jlbec@evilplan.org>
To: Marcelo Tosatti <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
Subject: WDIOC_SETTIMEOUT
Message-ID: <20020116015228.H1929@parcelfarce.linux.theplanet.co.uk>
Mail-Followup-To: Joel Becker <jlbec@evilplan.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>,
	lkml <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
X-Burt-Line: Trees are cool.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo,
	Here is the WDIOC_SETTIMEOUT patch again.  I have not heard any
more comments from driver authors.  Please consider for inclusion in
2.4.18.  It patches clean against 2.4.17, let me know if you need
anything else.

Thanks
Joel

-- 

"I don't even butter my bread; I consider that cooking."
         - Katherine Cebrian

			http://www.jlbec.org/
			jlbec@evilplan.org
