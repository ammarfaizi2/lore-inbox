Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262196AbVDGIRc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262196AbVDGIRc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Apr 2005 04:17:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262278AbVDGIPd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Apr 2005 04:15:33 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:14696 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262196AbVDGIOr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Apr 2005 04:14:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:references;
        b=Ga0zsrsOxmJxKt+hTm43igWCmOz2V8ffX3i4wa+83qDzLHkTP6lcsI3FMQ6CmWqfqexe36jone2g4XzARD8Vv/X09T+WNNV21uPH8Qit/TDbA6MaP5M0tiX09I6eTdA+15CnrjM7frdiMkDi4uheQ9WqS8BX3gyCsItHWAnV91M=
Message-ID: <aec7e5c30504070114711e0784@mail.gmail.com>
Date: Thu, 7 Apr 2005 10:14:44 +0200
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: David Lang <dlang@digitalinsight.com>
Subject: Re: Kernel SCM saga..
Cc: Martin Pool <mbp@sourcefrog.net>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
References: <Pine.LNX.4.58.0504060800280.2215@ppc970.osdl.org>
	 <20050406193911.GA11659@stingr.stingr.net>
	 <pan.2005.04.07.01.40.20.998237@sourcefrog.net>
	 <20050407014727.GA17970@havoc.gtf.org>
	 <pan.2005.04.07.02.25.56.501269@sourcefrog.net>
	 <Pine.LNX.4.62.0504061931560.10158@qynat.qvtvafvgr.pbz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Apr 7, 2005 4:32 AM, David Lang <dlang@digitalinsight.com> wrote:
> On Thu, 7 Apr 2005, Martin Pool wrote:
> 
> > I haven't tested importing all 60,000+ changesets of the current bk tree,
> > partly because I don't *have* all those changesets.  (Larry said
> > previously that someone (not me) tried to pull all of them using bkclient,
> > and he considered this abuse and blacklisted them.)
> 
> pull the patches from the BK2CVS server. yes some patches are combined,
> but it will get you in the ballpark.

While at it, is there any ongoing effort to convert/export the kernel
BK repository to some well known format like broken out patches and a
series file? I think keeping the complete repository public in a well
known format is important regardless of SCM taste.

/ magnus
