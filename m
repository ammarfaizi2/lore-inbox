Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312459AbSDSNCM>; Fri, 19 Apr 2002 09:02:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312460AbSDSNCL>; Fri, 19 Apr 2002 09:02:11 -0400
Received: from 127.141.hh1.ip.foni.net ([212.7.141.127]:2564 "HELO
	debian.heim.lan") by vger.kernel.org with SMTP id <S312459AbSDSNCK>;
	Fri, 19 Apr 2002 09:02:10 -0400
Content-Type: text/plain; charset=US-ASCII
From: Christian Schoenebeck <christian.schoenebeck@epost.de>
To: Marcelo de Paula Bezerra <mosca@mosca.yi.org>
Subject: Re: power off (again)
Date: Fri, 19 Apr 2002 15:05:38 +0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <20020418201220.C6D6247B1@debian.heim.lan> <1019162789.3361.0.camel@cristal>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020419123743.DDB6847B5@debian.heim.lan>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > >>> please cc me, I'm offlist <<<

Am Donnerstag, 18. April 2002 22:46 schrieb Marcelo de Paula Bezerra:
> Did you enable acpi and apm? Only apm, or only acpi?

I tried: APM only, ACPI only and I'm not really sure, but I think I also 
tried ACPI & APM, but AFAIK this automatically enables just one of them 
anyway.

>
> On Thu, 2002-04-18 at 17:40, Christian Schoenebeck wrote:
> >
> > Hi!
> >
> > I'm still fighting the problem that power off doesn't work with one of
> > our machines since moving from 2.2.19 to 2.4.7 kernel.
