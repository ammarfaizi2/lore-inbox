Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289226AbSCGBTY>; Wed, 6 Mar 2002 20:19:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289243AbSCGBTO>; Wed, 6 Mar 2002 20:19:14 -0500
Received: from r198m97.cybercable.tm.fr ([195.132.198.97]:63492 "EHLO lsinitam")
	by vger.kernel.org with ESMTP id <S289226AbSCGBS7> convert rfc822-to-8bit;
	Wed, 6 Mar 2002 20:18:59 -0500
Content-Type: text/plain; charset=US-ASCII
From: Laurent <laurent@augias.org>
To: linux-kernel@vger.kernel.org
Subject: ?chown and ?chown32 syscalls
Date: Thu, 7 Mar 2002 02:24:25 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16imdu-0000He-00@lsinitam>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In asm/unistd.h there are 2 series of syscalls for chown commands (chown, 
lchown and fchown) : the ?chown and ?chown32
In 2.4.17 (ix86) the system is using the ?chown32 syscalls, when I intercept 
the ?chown syscalls nothing happens. Are these syscalls deprecated ?

Thanks for any help.
Laurent Sinitambirivoutin
laurent@augias.org

PS: please CC: me the answers since I'm not on the list... ;)
