Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263457AbTJLM2o (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Oct 2003 08:28:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263464AbTJLM2o
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Oct 2003 08:28:44 -0400
Received: from main.gmane.org ([80.91.224.249]:57552 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S263457AbTJLM2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Oct 2003 08:28:43 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: mru@users.sourceforge.net (=?iso-8859-1?q?M=E5ns_Rullg=E5rd?=)
Subject: Re: Promise Ultra133-TX2 (PCD20269).
Date: Sun, 12 Oct 2003 14:28:37 +0200
Message-ID: <yw1xhe2eiqru.fsf@zaphod.guide>
References: <20031012121331.GA665@linux.comp>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-Complaints-To: usenet@sea.gmane.org
User-Agent: Gnus/5.1002 (Gnus v5.10.2) XEmacs/21.4 (Portable Code, linux)
Cancel-Lock: sha1:IuxdMzbdcPkRlPAz60WTmhvwOfw=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mark Williams (MWP)" <mwp@internode.on.net> writes:

> I am having rather ugly problems with this card using the PDC20269 chip.
> Almost as soon as either of the HDDs on the controller are used, the
> kernel hangs solid with a dump of debugging info.

That dump could be useful.  Also full output of dmesg and "lspci -vv"
can be helpful.

-- 
Måns Rullgård
mru@users.sf.net

