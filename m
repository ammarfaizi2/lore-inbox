Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285067AbRLFJSV>; Thu, 6 Dec 2001 04:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285063AbRLFJSO>; Thu, 6 Dec 2001 04:18:14 -0500
Received: from ultra02.rbg.informatik.tu-darmstadt.de ([130.83.9.52]:60897
	"EHLO mail.rbg.informatik.tu-darmstadt.de") by vger.kernel.org
	with ESMTP id <S285067AbRLFJRR>; Thu, 6 Dec 2001 04:17:17 -0500
Date: Thu, 6 Dec 2001 10:04:31 +0100
From: Philipp Matthias Hahn <pmhahn@titan.lahn.de>
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.17-pre3
Message-ID: <20011206100431.I1559@walker.iti.informatik.tu-darmstadt.de>
In-Reply-To: <Pine.LNX.4.21.0112051532140.20543-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
Content-Transfer-Encoding: 7BIT
In-Reply-To: <Pine.LNX.4.21.0112051532140.20543-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Wed, Dec 05, 2001 at 18:33:00 +0100
X-Mailer: Balsa 1.2.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hallo Marcelo and LKML!

On Wed, 05 Dec 2001 18:33:00 Marcelo Tosatti wrote:
> pre3:
...
> - Update tmpfs documentation                    (Christoph Rohland)
You removed/updated the documentation from Documentation/Configure.help
but forgot to add Documentation/filesystems/tmpfs.txt, which is now
mentioned in Configure.help

BYtE
Philipp
-- 
   / /  (_)__  __ ____  __ Philipp Hahn
  / /__/ / _ \/ // /\ \/ /
/____/_/_//_/\_,_/ /_/\_\ pmhahn@titan.lahn.de
