Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263340AbRFEUqR>; Tue, 5 Jun 2001 16:46:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263341AbRFEUqF>; Tue, 5 Jun 2001 16:46:05 -0400
Received: from pc7.prs.nunet.net ([199.249.167.77]:2312 "HELO
	pc7.prs.nunet.net") by vger.kernel.org with SMTP id <S263340AbRFEUp6>;
	Tue, 5 Jun 2001 16:45:58 -0400
Message-ID: <20010605204557.32315.qmail@pc7.prs.nunet.net>
From: "Rico Tudor" <rico-linux-kernel@patrec.com>
Subject: Re: lots of pppd (down) stall SMP linux-2.4.x
To: tip@prs.de
Date: Tue, 5 Jun 101 15:45:57 -0500 (CDT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3B1CE135.2D82A977@prs.de> from "Till Immanuel Patzschke" at Jun 5, 1 03:40:05 pm
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Try your test with "High Memory Support" disabled.
