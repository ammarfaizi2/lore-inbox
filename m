Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313781AbSDHWMb>; Mon, 8 Apr 2002 18:12:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313782AbSDHWMa>; Mon, 8 Apr 2002 18:12:30 -0400
Received: from jalon.able.es ([212.97.163.2]:57302 "EHLO jalon.able.es")
	by vger.kernel.org with ESMTP id <S313781AbSDHWMa>;
	Mon, 8 Apr 2002 18:12:30 -0400
Date: Tue, 9 Apr 2002 00:12:23 +0200
From: "J.A. Magallon" <jamagallon@able.es>
To: "Kuppuswamy, Priyadarshini" <Priyadarshini.Kuppuswamy@compaq.com>
Cc: Davide Libenzi <davidel@xmailserver.org>, linux-kernel@vger.kernel.org
Subject: Re: system call for finding the number of cpus??
Message-ID: <20020408221223.GE13043@werewolf.able.es>
In-Reply-To: <6B003D25ADBDE347B5542AFE6A55B42E01A44520@tayexc13.americas.cpqcorp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.3.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.04.08 "Kuppuswamy, Priyadarshini" wrote:
>I don't think that (sysconf(_SC_NPROCESSORS_CONF)) command works on linux. It works on Unix. I tried that. It returns 1 when there are 4 processors on linux.
>

Tried and works. get_nproc_conf and _SC_NPROCESSORS_CONF work the same.

-- 
J.A. Magallon                           #  Let the source be with you...        
mailto:jamagallon@able.es
Mandrake Linux release 8.3 (Cooker) for i586
Linux werewolf 2.4.19-pre6-jam1 #1 SMP Sun Apr 7 00:50:05 CEST 2002 i686
