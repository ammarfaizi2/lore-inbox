Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316649AbSE0PHM>; Mon, 27 May 2002 11:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316650AbSE0PHL>; Mon, 27 May 2002 11:07:11 -0400
Received: from jalon.able.es ([212.97.163.2]:26876 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S316649AbSE0PHL>;
	Mon, 27 May 2002 11:07:11 -0400
Date: Mon, 27 May 2002 17:07:00 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: Lista Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: [RFC] arch names
Message-ID: <20020527150700.GE6738@werewolf.able.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all...

After five minutes working on the arches patch, I realized that
if PII gets split away, CONFIG_M686 only stands for PPro, so it
would be worth a rename to CONFIG_MPENTIUMPRO ?

Only drawback is that people (ie - distros) could not just copy their old
.config and build...

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre8-jam4 #2 SMP dom may 26 11:20:42 CEST 2002 i686
