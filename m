Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130501AbRBNVq6>; Wed, 14 Feb 2001 16:46:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131281AbRBNVqs>; Wed, 14 Feb 2001 16:46:48 -0500
Received: from [213.96.124.18] ([213.96.124.18]:21996 "HELO dardhal")
	by vger.kernel.org with SMTP id <S130501AbRBNVqj>;
	Wed, 14 Feb 2001 16:46:39 -0500
Date: Wed, 14 Feb 2001 22:47:44 +0000
From: José Luis Domingo López 
	<jldomingo@crosswinds.net>
To: linux-kernel@vger.kernel.org
Subject: Are the sysctl and ptrace bugs already fixed ?
Message-ID: <20010214224744.A1302@dardhal.mired.net>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone:

Last week there was some advisories on the Bugtraq mailing list about
three problems with respect to both kernel series 2.2.x and 2.4.x. They
were about two possible local exploits trough sysctl and ptrace, and a
minor bug about machines with Pentium III processors (any local user could
potentially halt the CPU). At least RedHat and Caldera released patched
kernel packages for their distributions.

It seems that Alan Cox included a patch that fixes the sysctl()
vulnerability in 2.2.18-pre9 (I suppose it was really 2.2.19-pre9). But
with respect to the other two vulnerabilities on 2.2.x and the whole three
in kernel series 2.4.x haven't been able to find any information in
neither Bugtraq, nor in the Linux kernel development archives.

Am I missing something here ?.

PS: first message on the list. Don't be too cruel with me :)

-- 
José Luis Domingo López
Linux Registered User #189436     Debian GNU/Linux Potato (P166 64 MB RAM)
 
jdomingo AT internautas DOT   org  => Spam at your own risk

