Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262372AbVEMN4q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262372AbVEMN4q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 May 2005 09:56:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262369AbVEMN4q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 May 2005 09:56:46 -0400
Received: from zproxy.gmail.com ([64.233.162.201]:41503 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262372AbVEMN4n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 May 2005 09:56:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=NmAqtZl9iKwpknUNjWvUFgrnpyxPvAKYF8key/CfiGkYCkk4VfwGwJBNo/OaFcDBZaifR68l6YzV+/OaRRE2gnP0PhJS0bDBGG4W1K7JyA7XZ+oxBgy9JBcX7IUV5Fih/rjGMlSVGduyjnj6axiO5jGQJox/45HM1czz+76SN6s=
Date: Fri, 13 May 2005 22:56:36 +0900
From: Tejun Heo <htejun@gmail.com>
To: git@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [ANNOUNCE] mtkdiff 20050513
Message-ID: <20050513135636.GA18960@htj.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 Hello, guys.

 Here's mtkdiff 20050513.  Changes are

 * tarball name changed to mtkdiff from gitkdiff
 * gitkdiff modified to use the new git-* commands
 * gitkdiff no automtically locates git repository root, so you can
   execute it from any sub-directory.
 * quiltkdiff added.  It shows all the patches in the series with
   mtkdiff.
 * gitgrep added.  This isn't really related to mtkdiff or git, but
   I use it all the time and didn't wanna put it separately. :-)

 http://home-tj.org/mtkdiff/files/mtkdiff-20050513.tar.gz

 Thanks.

-- 
tejun
