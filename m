Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161106AbWBNQNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161106AbWBNQNO (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 11:13:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161109AbWBNQNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 11:13:14 -0500
Received: from web81911.mail.mud.yahoo.com ([68.142.207.190]:39271 "HELO
	web81911.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1161106AbWBNQNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 11:13:13 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=sbcglobal.net;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=a4pVo5ZXZ6T8MEHCCvqBTq285rWdTBXPQ+WinTU1QrRM9/6DnksUBhmXEszkLcc/qMM7/sfHJ8FydV2stWv5K7EjJKUgjM4sohD1tnPyYCL93+OZ2cdmMob4VlobuI0LLBr4JkblYDWG1tUFxDQZNlYmiKyHGR56XkUZzKuozcI=  ;
Message-ID: <20060214161311.68562.qmail@web81911.mail.mud.yahoo.com>
Date: Tue, 14 Feb 2006 08:13:11 -0800 (PST)
From: Matthew Frost <artusemrys@sbcglobal.net>
Subject: Re: The naming of at()s is a difficult matter
To: "H. Peter Anvin" <hpa@zytor.com>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>
Cc: jengelh@linux01.gwdg.de, linux-kernel@vger.kernel.org, drepper@redhat.com,
       austin-group-l@opengroup.org
In-Reply-To: <43F1F56C.7000307@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--- "H. Peter Anvin" <hpa@zytor.com> wrote:

> Joerg Schilling wrote:
> > 
> > I am not shure if this would match the rules from the Opengroup.
> > Solaris has these interfaces since at least 5 years.
> > 
> 
> Surely you're not suggesting that TOG's job is to rubber-stamp bad 
> Solaris decisions...

No, he's suggesting that precedent should apply across unixen.  It makes
sense to Joerg, who programs for the lot of them like they share object
inheritance.  This is sometimes more problematic than others (vis a vis
cdrecord).  Joerg is disinclined to support the kind of compulsive
re-engineering that Linus encourages, even though you might do it because
it would make more sense re-engineered a certain way.  If I've understood
correctly (and charitably), he prefers compatibility over novelty.

I myself like functional novelty over conformant compatibility in the
adiaphora.

Matt

> 
> 	-hpa
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

