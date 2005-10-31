Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750740AbVJaOSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750740AbVJaOSR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 09:18:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVJaOSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 09:18:17 -0500
Received: from xproxy.gmail.com ([66.249.82.202]:25935 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1750740AbVJaOSQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 09:18:16 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=d8Iqu78vIEWolBNZFOx0hIwI64MyMl9lxcsokBXz9Wa9tzk3vghgptVgUahMGTrDOR3Up7Z8OHSc8fIwdIigYqdzHP7pvaXkiIo9HyTvqIJoukhCe/Bzsh0KGh4nuLpbJI3gs5Ve8HOTlRvyK4Kb/aLxKia9iqRjNKNiwnqE8bQ=
Message-ID: <5a4c581d0510310618u61238417r69fe701e46612160@mail.gmail.com>
Date: Mon, 31 Oct 2005 15:18:15 +0100
From: Alessandro Suardi <alessandro.suardi@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [2.6.14-git3] KDGKBSENT: Operation not permitted upon login
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Freshly built 2.6.14-git3, upon logging on virtual consoles
 (tty2, tty3) I get this on the virtual console (not in dmesg,
 not in /var/log/messages):

KDGKBSENT: Operation not permitted
KDGKBSENT failed at index 0:

The messages seem harmless, I can startx fine and have
 so far no problem from the X session started from that tty.

--alessandro

 "All it takes is one decision
  A lot of guts, a little vision to wave
  Your worries, and cares goodbye"

   (Placebo - "Slave To The Wage")
