Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751255AbWBJNZe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751255AbWBJNZe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Feb 2006 08:25:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751259AbWBJNZe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Feb 2006 08:25:34 -0500
Received: from zproxy.gmail.com ([64.233.162.194]:57215 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751255AbWBJNZe convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Feb 2006 08:25:34 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PxLdnUssb8DCvmVqtZ1GqwPNdwLj8TJ7V91lNJitQU/97wh5n2fbnXoer1Y+K8xYiOwU3Z4x9/D/XZn6gY/fQHvEO13nYm5cDt/T/JdC6ypUY5I2OXhtr37PMxiroOMj2bGF7cvah393+TCVfBAww1se6QSfJBrMsSn2smWLkF4=
Message-ID: <d120d5000602100525w752b6df8t6c72a9a4164bdbcf@mail.gmail.com>
Date: Fri, 10 Feb 2006 08:25:33 -0500
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Reply-To: dtor_core@ameritech.net
To: Joerg Schilling <schilling@fokus.fraunhofer.de>
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
Cc: dhazelton@enter.net, peter.read@gmail.com, mj@ucw.cz,
       matthias.andree@gmx.de, linux-kernel@vger.kernel.org,
       jim@why.dont.jablowme.net, jengelh@linux01.gwdg.de
In-Reply-To: <43EC8F22.nailISDL17DJF@burner>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060208162828.GA17534@voodoo>
	 <20060210114721.GB20093@merlin.emma.line.org>
	 <43EC887B.nailISDGC9CP5@burner>
	 <200602090757.13767.dhazelton@enter.net>
	 <43EC8F22.nailISDL17DJF@burner>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/10/06, Joerg Schilling <schilling@fokus.fraunhofer.de> wrote:
> "D. Hazelton" <dhazelton@enter.net> wrote:
>
> > And does cdrecord even need libscg anymore? From having actually gone through
> > your code, Joerg, I can tell you that it does serve a larger purpose. But at
> > this point I have to ask - besides cdrecord and a few other _COMPACT_ _DISC_
> > writing programs, does _ANYONE_ use libscg? Is it ever used to access any
> > other devices that are either SCSI or use a SCSI command protocol (like
> > ATAPI)?  My point there is that you have a wonderful library, but despite
> > your wishes, there is no proof that it is ever used for anything except
> > writing/ripping CD's.
>
> Name a single program (not using libscg) that implements user space SCSI and runs
> on as many platforms as cdrecord/libscg does.
>

Joerg,

Please name a single program/package besides cdrtools that is using
libscg. Face it, you created and maintained a very decent CD writing
program but world domination is a bit out of reach.

--
Dmitry
