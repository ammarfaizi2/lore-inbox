Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135978AbREGCat>; Sun, 6 May 2001 22:30:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135979AbREGCaj>; Sun, 6 May 2001 22:30:39 -0400
Received: from dial249.pm3abing3.abingdonpm.naxs.com ([216.98.75.249]:21768
	"EHLO ani.animx.eu.org") by vger.kernel.org with ESMTP
	id <S135978AbREGCaW>; Sun, 6 May 2001 22:30:22 -0400
Date: Sun, 6 May 2001 22:39:33 -0400
From: Wakko Warner <wakko@animx.eu.org>
To: linux-kernel@vger.kernel.org
Subject: Success 2.4.4 on noritake alpha
Message-ID: <20010506223933.A4774@animx.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I tested 2.4.4 on my alpha server 1000a with an adaptec aha-2940UW card. 
Before it would always give me some kinds of errors when doing simutanious
writes to 3 drives on that card.

I'm currently running with this controller on the same 3 drives using LVM
and reiserfs ontop of that.  Works well.

-- 
 Lab tests show that use of micro$oft causes cancer in lab animals
