Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVCMLLm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVCMLLm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 06:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261153AbVCMLLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 06:11:42 -0500
Received: from main.gmane.org ([80.91.229.2]:37059 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S261151AbVCMLLk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 06:11:40 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Jan Rychter <jan@rychter.com>
Subject: Re: RFD: Kernel release numbering
Date: Sun, 13 Mar 2005 12:11:34 +0100
Message-ID: <m2acp7reah.fsf@tnuctip.rychter.com>
References: <200503031644.j23Gi0Eh011165@laptop11.inf.utfsm.cl>
	<Pine.LNX.4.58.0503030855460.25732@ppc970.osdl.org>
	<20050303152825.08e7e4c6.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: g5.rychter.com
X-Spammers-Please: blackholeme@rychter.com
User-Agent: Gnus/5.110003 (No Gnus v0.3) XEmacs/21.5-b19 (linux)
Cancel-Lock: sha1:1WEzWD8stDJwWQOhvcD/1/DXUu8=
X-Gmane-MailScanner: Found to be clean
X-Gmane-MailScanner: Found to be clean
X-MailScanner-From: glk-linux-kernel@m.gmane.org
X-MailScanner-To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Andrew" == Andrew Morton <akpm@osdl.org> writes:
 Andrew> Linus Torvalds <torvalds@osdl.org> wrote:
 >>
 >> Now, I haven't actually gotten any complaints about 2.6.11 (apart
 >> from "gcc4 still has problems" with fairly trivial solutions)

 Andrew> There have been quite a few.  Mainly driver stuff again:
[...]
 Andrew> The biggest problem is the new ACPI-based i8042 probing on
 Andrew> Dells.  I'm kicking myself over that because we *knew* the damn
 Andrew> thing was busted, and people kept on having to add
 Andrew> i8042.noacpi=1.  We now have a three-line
 Andrew> work-around-it-until-we-fix-it-for-real patch.

FWIW, this "minor regression" also occurs on other laptops, such as my
Sharp Mebius.

--J.

