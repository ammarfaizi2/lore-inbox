Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316880AbSFFKcU>; Thu, 6 Jun 2002 06:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316915AbSFFKcT>; Thu, 6 Jun 2002 06:32:19 -0400
Received: from krusty.dt.E-Technik.Uni-Dortmund.DE ([129.217.163.1]:57861 "EHLO
	mail.dt.e-technik.uni-dortmund.de") by vger.kernel.org with ESMTP
	id <S316880AbSFFKcT>; Thu, 6 Jun 2002 06:32:19 -0400
Date: Thu, 6 Jun 2002 12:32:15 +0200
From: Matthias Andree <matthias.andree@stud.uni-dortmund.de>
To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: lk-changelog.pl now to parse bk changes - output
Message-ID: <20020606103215.GA15026@merlin.emma.line.org>
Mail-Followup-To: Linux-Kernel mailing list <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.99i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I released lk-changelog.pl v0.26, my changelog reformatter, which does
parse the "bk changes" output format (this was reported by Marcelo
Tosatti) and not only the format of the BK-kernel-tools/changelog script
(which Linus uses).

I'm not pasting my program this time, as the next version is supposed to
pull the log out of bitkeeper itself.

Find v0.26 at http://mandree.home.pages.de/linux/kernel/

-- 
Matthias Andree
