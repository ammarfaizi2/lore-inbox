Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262428AbREUJzX>; Mon, 21 May 2001 05:55:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262431AbREUJzN>; Mon, 21 May 2001 05:55:13 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:7005 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S262428AbREUJzI>; Mon, 21 May 2001 05:55:08 -0400
Message-ID: <3B08E5F1.BD33D6F7@stud.uni-saarland.de>
Date: Mon, 21 May 2001 09:54:57 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: jbk@postmark.net
CC: linux-kernel@vger.kernel.org
Subject: Re: tulip driver BROKEN in 2.4.5-pre4
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Could you post the output of

#tulip-diag -mm -aa -f

with the broken driver?
Some code that's required for Linksys Tulip clones was moved from pnic
specific part into the generic part, perhaps that causes problems.

--
	Manfred
