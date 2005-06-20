Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261468AbVFTSzA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261468AbVFTSzA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Jun 2005 14:55:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261464AbVFTSyY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Jun 2005 14:54:24 -0400
Received: from rproxy.gmail.com ([64.233.170.206]:57614 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261456AbVFTSxz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Jun 2005 14:53:55 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=S1K1Y+Pz9U3+ceOlfOhPo8V9wI1rZ4W3wdB/WWHypdm5gDx5/gs2BGyeBhSvKaQEKvydiVRwcf35ufUTpfUMLUOGxiocSZ6tocGEOhYxJBmhwq0LGVJLs2HVFwEZughB6dEHFQGpeIWhRzgY1dr0cKSjnrFKuC4KHRhtKpmW9Ds=
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: kernel bugzilla
Date: Mon, 20 Jun 2005 22:59:38 +0400
User-Agent: KMail/1.7.2
Cc: linux-kernel@vger.kernel.org
References: <20050617001330.294950ac.akpm@osdl.org> <200506181850.35381.adobriyan@gmail.com> <20050618112342.6a4d088f.akpm@osdl.org>
In-Reply-To: <20050618112342.6a4d088f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200506202259.38682.adobriyan@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 18 June 2005 22:23, Andrew Morton wrote:
> Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > On Saturday 18 June 2005 01:39, Andrew Morton wrote:
> > > We should encourage people to use bugzilla as the initial
> > > entry-point.  But if someone instead uses email as the first contact I'm
> > > just a little bit reluctant to say "thanks, now go and try again".
> > > 
> > > Perhaps we could find some nice volunteer (hint) who could take the task of
> > > transferring such reports into bugzilla.
> > 
> > Andrew, I'm going to file
> > 
> > 	Subject: 2.6.12: connection tracking broken?
> > 	Subject: 2.6.12 cpu-freq conservative governor problem
> > 	Subject: PROBLEM: libata + sata_sil on sil3112 dosen't work proper
> > 	Subject: [2.6.12] x86-64 IO-APIC + timer doesn't work
> > 
> > around monday evening if there would be no activity.
> 
> Sounds good, thanks - let us know how it goes.
> 
> It'll need to be coordinated with the reporter in some way.  It may end up
> too confusing.
> 
> > Do I understand correctly that the procedure is
> > 
> > 	1. Search for duplicates
> > 	2. Choose category
> > 	3. Add "From: Joe Reporter <>" at the beginning, copy-paste email.
> > 	4. Add Joe and relevant lists to CC.

Craaap.

"The name <mailing list> is not a valid username. Either you misspelled it,
or the person has not registered for a Bugzilla account."

Same for Joe Reporter. :-(

> > 	5. Profi^WCommit
> > 
> > and bugzilla won't shoot unsuspecting guys afterwards?
> 
> I think so.  I've never entered a bug ;)
