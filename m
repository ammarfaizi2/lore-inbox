Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964775AbWHKU2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964775AbWHKU2M (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 16:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWHKU2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 16:28:12 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:47359 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932379AbWHKU2L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 16:28:11 -0400
From: Arnd Bergmann <arnd@arndb.de>
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 0/4]:  powerpc/cell spidernet ethernet driver fixes
Date: Fri, 11 Aug 2006 22:27:22 +0200
User-Agent: KMail/1.9.1
Cc: Sam Ravnborg <sam@ravnborg.org>, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       James K Lewis <jklewis@us.ibm.com>, Utz Bacher <utz.bacher@de.ibm.com>,
       Jens Osterkamp <Jens.Osterkamp@de.ibm.com>
References: <20060811170337.GH10638@austin.ibm.com> <20060811174439.GA30191@mars.ravnborg.org> <20060811193102.GN10638@austin.ibm.com>
In-Reply-To: <20060811193102.GN10638@austin.ibm.com>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200608112227.24140.arnd@arndb.de>
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 11 August 2006 21:31, Linas Vepstas wrote:
> I put my name at the top when I was the primary author. 
> I put Jim's name at the top when he was the primary author. 
> 
> Both names are there because I sat in Jim's office and used
> his keyboard. I got him to compile and run the tests on
> his hardware, and we'd then debate the results.

When the patch gets added to a git repository, they end up
having your name on it, because the author is determined
from the person who sent the patch.

For the patches where Jim is the main author, you should put a 

From: James K Lewis <jklewis@us.ibm.com>

into the first line of the email body. That will make the
scripts do the right thing. The order of the Signed-off-by:
lines is used is independant from authorship and should
list the name of the submitter last.

	Arnd <><
