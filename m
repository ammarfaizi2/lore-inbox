Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315218AbSG3PK0>; Tue, 30 Jul 2002 11:10:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317852AbSG3PKZ>; Tue, 30 Jul 2002 11:10:25 -0400
Received: from 212.Red-80-35-44.pooles.rima-tde.net ([80.35.44.212]:128 "EHLO
	DervishD.pleyades.net") by vger.kernel.org with ESMTP
	id <S315218AbSG3PKZ>; Tue, 30 Jul 2002 11:10:25 -0400
Date: Tue, 30 Jul 2002 17:21:19 +0200
Organization: Pleyades
To: Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Clearing the terminal portably
Message-ID: <3D46AEEF.mail2H19I8Z8@viadomus.com>
User-Agent: nail 9.31 6/18/02
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
From: DervishD <raul@pleyades.net>
Reply-To: DervishD <raul@pleyades.net>
X-Mailer: DervishD TWiSTiNG Mailer
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi all :))

    I want to clear a terminal more or less 'portably' but without
using curses (that's forced). I must work at least for the TERM
'linux' and it would be great if it works on all linux platforms. The
portability is intended *only* within different linux archs, not
more.

    I currently write 'ESC c' to the terminal and it works (it is the
reset code for a 'linux' TERM), but I wonder if there is a better way.

    Thanks a lot :)
    Raúl
