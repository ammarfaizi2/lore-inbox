Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUCVJlC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Mar 2004 04:41:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261847AbUCVJlC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Mar 2004 04:41:02 -0500
Received: from mail-10.iinet.net.au ([203.59.3.42]:40324 "HELO
	mail.iinet.net.au") by vger.kernel.org with SMTP id S261843AbUCVJk7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Mar 2004 04:40:59 -0500
Date: Mon, 22 Mar 2004 17:40:53 +0800
From: Cameron Patrick <cameron@patrick.wattle.id.au>
To: Michael Frank <mhf@linuxmail.org>
Cc: pcg@goof.com, Pavel Machek <pavel@suse.cz>,
       Software Suspend - Mailing Lists 
	<swsusp-devel@lists.sourceforge.net>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: [Swsusp-devel] (no subject)
Message-ID: <20040322094053.GO16890@patrick.wattle.id.au>
Mail-Followup-To: Michael Frank <mhf@linuxmail.org>, pcg@goof.com,
	Pavel Machek <pavel@suse.cz>,
	Software Suspend - Mailing Lists <swsusp-devel@lists.sourceforge.net>,
	kernel list <linux-kernel@vger.kernel.org>
References: <opr49atvpk4evsfm@smtp.pacific.net.th>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <opr49atvpk4evsfm@smtp.pacific.net.th>
Organization: Parenthesis Conspiracy
User-Agent: Mutt/1.5.5.1+cvs20040105+cjp-1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Michael Frank wrote:

| >+ *   3.  The name of the author may not be used to endorse or promote products
| >+ *       derived from this software without specific prior written permission.
[...]
| >This looks like BSD with advertising clause. I do not think you are
| >allowed to link this with kernel. It does not follow kernel coding style.
[...]
| As said, BSD-only licensed code is _invalid_ to be linked with kernel code,
| therefor swsusp2 will have to drop LZF alltogether unless you relicense it.

The licence above looks like BSD /without/ advertising clause, which
is GPL compatible.  Note that the (GPL-incompatible) advertising
clause is the one that says "mention me in your advertising materials"
whereas the above licence only requires mention in accompanying
documentation and says /not/ to use the name of the author to promote
derived works.

See also http://www.gnu.org/philosophy/license-list.html, under "The
modified BSD license":

    This is the original BSD license, modified by removal of the
    advertising clause. It is a simple, permissive non-copyleft free
    software license, compatible with the GNU GPL.

The licence so described looks to me the same as LZF's licence.

Cheers,

Cameron.

