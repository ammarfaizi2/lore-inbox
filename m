Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267632AbUBTGpJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Feb 2004 01:45:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267636AbUBTGpJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Feb 2004 01:45:09 -0500
Received: from herkules.viasys.com ([194.100.28.129]:10180 "HELO
	mail.viasys.com") by vger.kernel.org with SMTP id S267632AbUBTGpD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Feb 2004 01:45:03 -0500
Date: Fri, 20 Feb 2004 08:44:59 +0200
From: Ville Herva <vherva@viasys.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Nur Hussein <obiwan@slackware.org.my>, linux-kernel@vger.kernel.org
Subject: mremap patches for 2.4 and 2.2?
Message-ID: <20040220064459.GF3767@viasys.com>
Reply-To: vherva@viasys.com
References: <1077201466.1636.19.camel@sophia.localdomain> <20040219170051.6b97f6bf.diegocg@teleline.es> <1077212582.223.17.camel@sophia.localdomain> <20040219095636.D22989@build.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040219095636.D22989@build.pdx.osdl.net>
User-Agent: Mutt/1.4.1i
X-Operating-System: Linux herkules.viasys.com 2.4.25-rc2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 19, 2004 at 09:56:36AM -0800, you [Chris Wright] wrote:
> * Nur Hussein (obiwan@slackware.org.my) wrote:
> > However, I am still intrigued by this fix:
> > 
> > http://linux.bkbits.net:8080/linux-2.4/diffs/mm/mremap.c@1.7?nav=cset@1.1136.94.4
> > 
> > It does not seem to be in 2.6.3. I can only assume 2.6.x does not
> > require it? The Changeset says it is to prevent a potential exploit by
> > the malicious use of mremap().
> 
> It's fixed in 2.6 as well.
> 
> http://linux.bkbits.net:8080/linux-2.5/diffs/mm/mremap.c@1.35?nav=index.html|src/|src/mm|hist/mm/mremap.c

Are these the sole patches one should apply for this vulnerability if
patching an older 2.4 or 2.6?

Is there a patch for 2.2 somewhere?


-- v --

v@iki.fi
