Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262373AbTFXRNc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 13:13:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262383AbTFXRNc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 13:13:32 -0400
Received: from mail.skjellin.no ([80.239.42.67]:38342 "HELO mail.skjellin.no")
	by vger.kernel.org with SMTP id S262373AbTFXRNa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 13:13:30 -0400
Subject: bkbits.net web UI oddities after last crash
From: Andre Tomt <andre@tomt.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Organization: 
Message-Id: <1056475651.7646.128.camel@slurv.ws.pasop.tomt.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4- 
Date: 24 Jun 2003 19:27:31 +0200
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

I noticed some rather strange behavior from
http://linux.bkbits.net:8080/linux-2.4

Lets say, I go to
http://linux.bkbits.net:8080/linux-2.4/ChangeSet@-7d?nav=index.html

So far, so good. No oddities here. Then I find "1.1002.3.2" in the list.
"[IPV4]: Be more verbose about invalid ICMPs sent to broadcast."

I click it. Okay, page comes up nicely, the header seems a little
strange, though. But that might just be a feature change (I'm not a
BK-user, yet). It claims I'm looking at ChangeSet
3ef76015xckdLSammmd1kjiJ7CJY4Q. Isn't ChaneSet's named by a number? Not
minding that too much, I click on the "all diffs" link. Returns nothing.
Hmm.. ok, lets click on "diffs" for the single affected file instead,
and behold, the right diff pops up. I try the same on some other changes
in the list, the same problems appear.

Whats happening?

-- 
Cheers,
André Tomt

