Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289185AbSA3NCV>; Wed, 30 Jan 2002 08:02:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289190AbSA3NCL>; Wed, 30 Jan 2002 08:02:11 -0500
Received: from ligsg2.epfl.ch ([128.178.78.4]:16503 "HELO ligsg2.epfl.ch")
	by vger.kernel.org with SMTP id <S289183AbSA3NCE>;
	Wed, 30 Jan 2002 08:02:04 -0500
Message-Id: <m16VuNG-0210zpC@ligsg2.epfl.ch>
Content-Type: text/plain; charset=US-ASCII
From: Jan Ciger <jan.ciger@epfl.ch>
Reply-To: jan.ciger@epfl.ch
Organization: EPFL
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre7 + O(1) scheduler hangs
Date: Wed, 30 Jan 2002 14:02:01 +0100
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I experience strange problem with 2.4.18-pre7 and latest version (-J9) of the 
O(1) scheduler. After one or two days of uptime, I get hanged shells, when 
trying to execute ps, top and similar things. I saw some mention from Ingo 
about 'frozen shells' before, but I didn't find anything more detailed about 
that. Is this problem a known "feature" already ? I had this problem with 
prior versions of O(1) patches too. 

Jan

